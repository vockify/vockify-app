import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/spell_check/spell_check_request_dto.dart';
import 'package:vockify/src/api/dto/translate/translate_request_dto.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/services/amplitude.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/start_user_term_form/history_term_list.dart';
import 'package:vockify/src/widgets/start_user_term_form/user_term_text_field.dart';
import 'package:vockify/src/widgets/user_term_form/definition_chips.dart';
import 'package:vockify/src/widgets/user_term_form/spell_check_text.dart';
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

  Timer _onStoppedTyping;

  String _term = '';
  String _transcription = '';
  String _spellCheckedTerm = '';

  List<String> _definitions = [];
  List<String> _selectedDefinitions = [];

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
      const duration = Duration(milliseconds: 400);

      if (_onStoppedTyping != null) {
        setState(() => _onStoppedTyping.cancel());
      }

      if (_term != _nameController.text) {
        setState(() => _onStoppedTyping = new Timer(duration, () {
              _translate(_nameController.text);
            }));
      }

      if (_nameController.text.isEmpty) {
        setState(() {
          _term = '';
          _transcription = '';
          _spellCheckedTerm = '';
          _definitions = [];
        });
      }
    });
  }

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
            if (_term.isNotEmpty) ...[
              if (_definitions.isNotEmpty) ...[
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 80),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Text(
                              _getPrimaryDefinition(),
                              style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 24),
                            ),
                          ),
                          if (_hasTranscription())
                            TranscriptionTextWidget(
                              term: _term,
                              transcription: _transcription,
                            ),
                          if (_areDefinitionChipsVisible())
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
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.bottomCenter,
                  child: _buildAddButton(),
                ),
              ],
              if (_definitions.isEmpty && _spellCheckedTerm.isNotEmpty && !_isTyping())
                SpellCheckTextWidget(
                  onTap: () {
                    _nameController.text = _spellCheckedTerm;
                    FocusScope.of(context).unfocus();
                  },
                  text: _spellCheckedTerm,
                  padding: 16,
                ),
            ],
            if (_term.isEmpty)
              HistoryTermListWidget(onTap: (value) {
                _nameController.text = value;
                FocusScope.of(context).unfocus();

                amplitude.logEvent('start_screen_history_term_clicked', eventProperties: {
                  'term': value,
                });
              }),
          ],
        ),
      ],
    );
  }

  bool _isTyping() => _onStoppedTyping != null && _onStoppedTyping.isActive;

  bool _areDefinitionChipsVisible() => _definitions.length > 0;

  String _getPrimaryDefinition() => _definitions.first;

  bool _hasTranscription() => _transcription.isNotEmpty && _term.isNotEmpty;

  Widget _buildAddButton() {
    final definition = _selectedDefinitions.isEmpty ? _definitions.first : _selectedDefinitions.join(', ');

    return Row(
      children: <Widget>[
        Expanded(
          child: StoreConnector<AppState, List<TermState>>(
            distinct: true,
            converter: (store) => getLastAddedTerms(store.state),
            builder: (context, terms) {
              return RawMaterialButton(
                padding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                fillColor: VockifyColors.prussianBlue,
                onPressed: () {
                  dispatcher.dispatch(
                    NavigateToAction.push(Routes.userSetSelect, arguments: {
                      'term': _term,
                      'definition': definition,
                      'selectedSetIds': terms.where((term) => term.name == _term).map((term) => term.setId).toList(),
                    }),
                  );

                  amplitude.logEvent('start_screen_add_button_clicked', eventProperties: {
                    'term': _term,
                    'definitions': _definitions,
                  });
                },
                child: Text(
                  'Добавить в словарь',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: VockifyColors.white,
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

  Future<void> _translate(String text) async {
    if (text.isEmpty) {
      return;
    }

    final data = (await api.translate(TranslateRequestDto(text))).data;

    if (data.isEmpty) {
      _spellCheck(text);
    }

    _selectedDefinitions.clear();

    setState(() {
      _term = text;
      _transcription = data.length > 0 ? data.first.transcription : '';
      _definitions = data.expand((entry) => entry.translations.map((tr) => tr.text)).toList();
    });

    amplitude.logEvent('start_screen_term_translated', eventProperties: {
      'term': _term,
      'definitions': _definitions,
    });
  }

  Future<void> _spellCheck(String text) async {
    if (text.isEmpty) {
      return;
    }

    final data = await api.spellCheck(SpellCheckRequestDto(text));

    if (data.isNotEmpty) {
      setState(() {
        _spellCheckedTerm = data.first?.strings?.first;
      });
    }
  }
}
