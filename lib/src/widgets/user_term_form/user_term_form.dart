import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/translate/translate_request_dto.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/primary_text_form_field.dart';

class UserTermFormWidget extends StatefulWidget {
  final Key formKey;
  final TextEditingController termController;
  final TextEditingController definitionController;

  const UserTermFormWidget({Key key, this.termController, this.definitionController, this.formKey}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserTermFormState();
}

class _UserTermFormState extends State<UserTermFormWidget> {
  String _term = '';
  String _definition = '';
  String _transcription = '';

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
              if (_isDefinitionChipsVisible())
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Выберите значения:',
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant UserTermFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.termController.text.isNotEmpty) {
      _translate();
    }

    _definition = widget.definitionController.text;

    if (widget.definitionController.text.isNotEmpty) {
      _selectedDefinitions = widget.definitionController.text.split(', ');
    }
  }

  void initState() {
    super.initState();

    if (widget.termController.text.isNotEmpty) {
      _translate();
    }

    _definition = widget.definitionController.text;

    if (widget.definitionController.text.isNotEmpty) {
      _selectedDefinitions = widget.definitionController.text.split(', ');
    }

    widget.termController.addListener(() {
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
    });

    widget.definitionController.addListener(() {
      if (widget.definitionController.text != _definition) {
        setState(() {
          _definition = widget.definitionController.text;
          _selectedDefinitions =
              widget.definitionController.text.split(', ').where((definition) => definition.isNotEmpty).toList();
        });
      }
    });
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

              widget.definitionController.text = _selectedDefinitions.join(', ');
            });
          },
        );
      }).toList(),
    );
  }

  bool _hasTranscription() => _transcription != '';

  bool _isDefinitionChipsVisible() => _definitions.length > 1;

  Future<void> _translate() async {
    if (widget.termController.text.isEmpty || widget.termController.text == _term) {
      return;
    }

    try {
      final data = await api.translate(TranslateRequestDto(widget.termController.text));

      final userDefinitions = widget.definitionController.text.split(', ');

      setState(() {
        _term = data.data.term;
        _transcription = data.data.transcription;
        _definitions = data.data.definitions;

        _selectedDefinitions = _definitions.where((definition) => userDefinitions.contains(definition)).toList();
      });
    } catch (e) {
      print(e);
    }
  }
}
