import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/models/term_model/term_model.dart';
import 'package:vockify/src/pages/term/widgets/user_term_form.dart';
import 'package:vockify/src/models/app_model.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/layout.dart';

class UserTermPageWidget extends StatefulWidget {
  final int setId;
  final int? termId;

  UserTermPageWidget({
    required this.setId,
    this.termId,
  });

  @override
  State<StatefulWidget> createState() => _UserTermPageState();
}

class _UserTermPageState extends State<UserTermPageWidget> {
  final _termController = TextEditingController();
  final _definitionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutWidget(
        title: 'Редактировать',
        actions: <Widget>[
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.check,
              color: VockifyColors.fulvous,
            ),
            onPressed: _save,
            padding: EdgeInsets.all(16),
          ),
        ],
        body: UserTermFormWidget(
          formKey: _formKey,
          termController: _termController,
          definitionController: _definitionController,
          onSave: _save,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _definitionController.dispose();
    _termController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    if (widget.termId != null) {
      final setsState = context.read<AppModel>();
      final term =
          setsState.state.sets[widget.setId]!.terms.terms[widget.termId]!;

      _termController.text = term.name;
      _definitionController.text = term.definition;
    }

    super.initState();
  }

  void _save() {
    final setsState = context.read<AppModel>();

    if (_formKey.currentState?.validate() ?? false) {
      if (widget.termId != null) {
        setsState.updateTerm(
          widget.setId,
          TermModel(
            id: widget.termId!,
            setId: widget.setId,
            name: _termController.text,
            definition: _definitionController.text,
          ),
        );
      } else {
        setsState.addTerm(
          widget.setId,
          TermModel(
            id: 0,
            setId: widget.setId,
            name: _termController.text,
            definition: _definitionController.text,
          ),
        );
      }

      Navigator.of(context).pop();
    }
  }
}
