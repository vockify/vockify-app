import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/translate/translate_request_dto.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/start_user_term_form/user_term_text_field.dart';
import 'package:vockify/src/widgets/user_term_form/definition_chips.dart';
import 'package:vockify/src/widgets/user_term_form/transcription_text.dart';

class StartUserTermFormWidget extends StatefulWidget {
  final String term;

  const StartUserTermFormWidget({Key key, this.term}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StartUserTermFormState();
}

class _StartUserTermFormState extends State<StartUserTermFormWidget> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _term = '';
  String _transcription = '';

  List<String> _definitions = [];
  List<String> _selectedDefinitions = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: UserTermTextFieldWidget(
                controller: _nameController,
              ),
            ),
            if (_term.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 80),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 30),
                          child: Text(
                            _getPrimaryDefinition(),
                            style: Theme.of(context).textTheme.bodyText2.copyWith(
                                  fontSize: 24,
                                ),
                          ),
                        ),
                        if (_hasTranscription())
                          TranscriptionTextWidget(
                            term: _term,
                            transcription: _transcription,
                          ),
                        if (_isDefinitionChipsVisible())
                          DefinitionChipsWidget(
                            definitions: _definitions,
                            selectedDefinitions: _selectedDefinitions,
                            onChange: (updated) {
                              setState(() {
                                _selectedDefinitions = updated;
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
        if (_definitions.isNotEmpty)
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.bottomCenter,
            child: _buildAddButton(),
          ),
      ],
    );
  }

  @override
  void didUpdateWidget(covariant StartUserTermFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.term != null) {
      _nameController.text = widget.term;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }

  void initState() {
    super.initState();

    if (widget.term != null) {
      _nameController.text = widget.term;
    }

    _nameController.addListener(() {
      if (_nameController.text.isEmpty) {
        if (_definitions.isNotEmpty || _transcription.isNotEmpty) {
          setState(() {
            _term = '';
            _transcription = '';
            _definitions = [];
          });
        }
      }

      EasyDebounce.debounce(
        'translate',
        Duration(milliseconds: 500),
        _translate,
      );
    });
  }

  Widget _buildAddButton() {
    final definition = _selectedDefinitions.isEmpty ? _definitions.first : _selectedDefinitions.join(', ');

    return Row(
      children: <Widget>[
        Expanded(
          child: StoreConnector<AppState, String>(
            distinct: true,
            converter: (store) => getLastAddedTerm(store.state),
            builder: (context, lastAddedTerm) {
              final isTermAdded = lastAddedTerm == _term;

              return RawMaterialButton(
                padding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  side: isTermAdded
                      ? BorderSide(
                          color: VockifyColors.prussianBlue,
                        )
                      : BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                fillColor: isTermAdded ? VockifyColors.white : VockifyColors.prussianBlue,
                onPressed: () {
                  dispatcher.dispatch(
                    NavigateToAction.push(Routes.userSetSelect, arguments: {
                      'term': _term,
                      'definition': definition,
                    }),
                  );
                },
                child: Text(
                  isTermAdded ? 'Уже в словаре' : 'Добавить в словарь',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: isTermAdded ? VockifyColors.prussianBlue : VockifyColors.white,
                        fontSize: 16,
                      ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getPrimaryDefinition() => _definitions.first;

  bool _hasTranscription() => _transcription != '';

  bool _isDefinitionChipsVisible() => _definitions.length > 1;

  Future<void> _translate() async {
    if (_nameController.text.isEmpty || _nameController.text == _term) {
      return;
    }

    try {
      final data = await api.translate(TranslateRequestDto(_nameController.text));

      _selectedDefinitions.clear();

      setState(() {
        _term = data.data.term;
        _transcription = data.data.transcription;
        _definitions = data.data.definitions;
      });
    } catch (e) {
      print(e);
    }
  }
}
