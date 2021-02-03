import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/spell_check/spell_check_request_dto.dart';
import 'package:vockify/src/api/dto/translate/translate_request_dto.dart';
import 'package:vockify/src/widgets/common/primary_text_form_field.dart';
import 'package:vockify/src/widgets/user_term_form/definition_chips.dart';
import 'package:vockify/src/widgets/user_term_form/spell_check_text.dart';
import 'package:vockify/src/widgets/user_term_form/transcription_text.dart';

class UserTermFormWidget extends StatefulWidget {
  final Key formKey;
  final TextEditingController termController;
  final TextEditingController definitionController;

  const UserTermFormWidget({Key key, this.termController, this.definitionController, this.formKey}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserTermFormState();
}

class _UserTermFormState extends State<UserTermFormWidget> {
  static const _delimiter = ', ';

  String _term = '';
  String _definition = '';
  String _transcription = '';
  String _spellCheckedTerm = '';

  List<String> _definitions = [];
  List<String> _selectedDefinitions = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: widget.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PrimaryTextFormFieldWidget(
                controller: widget.termController,
                label: 'Английское слово',
              ),
              PrimaryTextFormFieldWidget(
                controller: widget.definitionController,
                label: 'Перевод',
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
                      widget.definitionController.text = updated.join(_delimiter);
                    });
                  },
                ),
              if (_spellCheckedTerm.isNotEmpty && _definitions.isEmpty)
                SpellCheckTextWidget(
                  onTap: () => setState(() {
                    widget.termController.text = _spellCheckedTerm;
                  }),
                  text: _spellCheckedTerm,
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant UserTermFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateState();
  }

  @override
  void dispose() {
    widget.termController.removeListener(_handleTermControllerChange);
    widget.definitionController.removeListener(_handleDefinitionControllerChange);

    super.dispose();
  }

  void initState() {
    super.initState();

    _updateState();

    widget.termController.addListener(_handleTermControllerChange);
    widget.definitionController.addListener(_handleDefinitionControllerChange);
  }

  List<String> _getUserDefinitions() => _definition.split(_delimiter);

  void _handleDefinitionControllerChange() {
    if (widget.definitionController.text != _definition) {
      setState(() {
        _definition = widget.definitionController.text;
        _selectedDefinitions = _getUserDefinitions().where((definition) => definition.isNotEmpty).toList();
      });
    }
  }

  void _handleTermControllerChange() {
    if (widget.termController.text.isEmpty) {
      if (_definitions.isNotEmpty || _transcription.isNotEmpty || _term.isNotEmpty) {
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
  }

  bool _hasTranscription() => _transcription != '';

  bool _areDefinitionChipsVisible() => _definitions.length > 0;

  Future<void> _translate() async {
    if (widget.termController.text.isEmpty || widget.termController.text == _term) {
      return;
    }

    final data = (await api.translate(TranslateRequestDto(widget.termController.text))).data;
    final userDefinitions = _getUserDefinitions();

    if (data.isEmpty) {
      _spellCheck(widget.termController.text);
    }

    setState(() {
      _term = data.length > 0 ? data.first.text : '';
      _transcription = data.length > 0 ? data.first.transcription : '';
      _definitions = data.expand((entry) => entry.translations.map((tr) => tr.text)).toList();

      _selectedDefinitions = _definitions.where((definition) => userDefinitions.contains(definition)).toList();
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

  void _updateState() {
    _definition = widget.definitionController.text;

    if (widget.termController.text.isNotEmpty) {
      _translate();
    }

    if (_definition.isNotEmpty) {
      _selectedDefinitions = _definition.split(_delimiter);
    }
  }
}
