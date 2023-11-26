import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/spell_check/spell_check_request_dto.dart';
import 'package:vockify/src/api/dto/translate/translate_request_dto.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/primary_text_form_field.dart';
import 'package:vockify/src/widgets/user_term_form/definition_chips.dart';
import 'package:vockify/src/widgets/user_term_form/skeleton_chips.dart';
import 'package:vockify/src/widgets/user_term_form/spell_check_text.dart';

class UserTermFormWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController termController;
  final TextEditingController definitionController;
  final Function onSave;


  const UserTermFormWidget({
    Key? key,
    required this.termController,
    required this.definitionController,
    required this.formKey,
    required this.onSave,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserTermFormState();
}

class _UserTermFormState extends State<UserTermFormWidget> {

  static const _delimiter = ', ';

  String _term = '';
  String _definition = '';
  String _transcription = '';
  String _spellCheckedTerm = '';

  bool _isLoading = false;

  List<String> _definitions = [];
  List<String> _selectedDefinitions = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Form(
                key: widget.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    PrimaryTextFormFieldWidget(
                      controller: widget.termController,
                      label: 'Термин',
                    ),
                    PrimaryTextFormFieldWidget(
                      controller: widget.definitionController,
                      label: 'Определение',
                    ),
                    if (!_isLoading)
                      DefinitionChipsWidget(
                        definitions: _definitions,
                        selectedDefinitions: _selectedDefinitions,
                        onChange: (updated) {
                          setState(() {
                            _selectedDefinitions = updated;
                            widget.definitionController.text = updated.join(_delimiter);
                          });
                        },
                      )
                    else
                      SkeletonChipsWidget(),
                    if (_spellCheckedTerm.isNotEmpty && _definitions.isEmpty)
                      SpellCheckTextWidget(
                        onTap: () => widget.termController.text = _spellCheckedTerm,
                        text: _spellCheckedTerm,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.bottomCenter,
          child: _buildSaveButton(),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: RawMaterialButton(
            padding: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            fillColor: VockifyColors.fulvous,
            onPressed: () {
              FocusScope.of(context).unfocus();
              widget.onSave();
            },
            child: Text(
              'СОХРАНИТь',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: VockifyColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void didUpdateWidget(UserTermFormWidget oldWidget) {
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
    } else if (_term != widget.termController.text) {
      setState(() {
        _isLoading = true;
      });
    }

    EasyDebounce.debounce(
      'translate',
      Duration(milliseconds: 500),
      _translate,
    );
  }

  Future<void> _translate() async {
    if (widget.termController.text.isEmpty || widget.termController.text == _term) {
      setState(() {
        _isLoading = false;
      });

      return;
    }

    final data = (await api.translate(TranslateRequestDto(widget.termController.text))).def;

    final userDefinitions = _getUserDefinitions();

    if (data.isEmpty) {
      _spellCheck(widget.termController.text);
    }

    setState(() {
      _term = data.length > 0 ? data.firstOrNull?.text ?? '' : '';
      _transcription = data.length > 0 ? data.firstOrNull?.transcription ?? '' : '';
      _definitions = data.expand((entry) => entry.translations.map((tr) => tr.text)).toList();

      _selectedDefinitions = _definitions.where((definition) => userDefinitions.contains(definition)).toList();

      _isLoading = false;
    });
  }

  Future<void> _spellCheck(String text) async {
    if (text.isEmpty) {
      return;
    }

    final data = await api.spellCheck(SpellCheckRequestDto(text));

    if (data.isNotEmpty) {
      setState(() {
        _spellCheckedTerm = data.firstOrNull?.strings.firstOrNull ?? '';
      });
    }
  }

  void _updateState() {
    _definition = widget.definitionController.text;

    if (widget.termController.text.isNotEmpty) {
      _translate();

      setState(() {
        _isLoading = true;
      });
    }

    if (_definition.isNotEmpty) {
      _selectedDefinitions = _definition.split(_delimiter);
    }
  }
}
