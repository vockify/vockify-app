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
import 'package:vockify/src/widgets/add_user_term/user_term_text_field.dart';

class AddUserTermWidget extends StatefulWidget {
  final String term;

  const AddUserTermWidget({Key key, this.term}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddUserTermState();
}

class _AddUserTermState extends State<AddUserTermWidget> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _term = '';
  String _transcription = '';
  List<String> _definitions = [];

  final List<String> _selectedDefinitions = [];

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
                            _definitions.first,
                            style: Theme.of(context).textTheme.bodyText2.copyWith(
                                  fontSize: 24,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: RichText(
                            text: TextSpan(
                              text: _term,
                              style: Theme.of(context).textTheme.bodyText2.copyWith(
                                    fontSize: 20,
                                  ),
                              children: [
                                TextSpan(
                                  text: ' [${_transcription}]',
                                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                                        fontSize: 20,
                                        color: VockifyColors.lightSteelBlue,
                                      ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Выберите перевод:',
                            style: Theme.of(context).textTheme.bodyText2.copyWith(
                                  fontSize: 16,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: _buildDefinitionChips(),
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
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AddUserTermWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.term != null) {
      _nameController.text = widget.term;
    }
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

  Widget _buildDefinitionChips() {
    return Wrap(
      spacing: 8,
      children: _definitions.map((definition) {
        return ChoiceChip(
          backgroundColor: VockifyColors.white,
          selectedColor: VockifyColors.lightSteelBlue,
          label: Text(
            definition,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 16,
                ),
          ),
          labelStyle: TextStyle(color: VockifyColors.black),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: VockifyColors.lightSteelBlue,
            ),
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          selected: _selectedDefinitions.contains(definition),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _selectedDefinitions.add(definition);
              } else {
                _selectedDefinitions.remove(definition);
              }
            });
          },
        );
      }).toList(),
    );
  }

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
