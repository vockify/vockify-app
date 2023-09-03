import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/api/dto/terms/term_dto.dart';
import 'package:vockify/src/redux/actions/terms/request_add_user_term_action.dart';
import 'package:vockify/src/redux/actions/terms/request_update_user_term_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/layout.dart';
import 'package:vockify/src/widgets/user_term_form/user_term_form.dart';

class UserTermScreenWidget extends StatefulWidget {
  final int setId;
  final int termId;

  UserTermScreenWidget({
    required this.setId,
    required this.termId,
  });

  @override
  State<StatefulWidget> createState() => _UserTermScreenState();
}

class _UserTermScreenState extends State<UserTermScreenWidget> {
  final _termController = TextEditingController();
  final _definitionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      route: Routes.userTerm,
      actions: <Widget>[
        RawMaterialButton(
          constraints: BoxConstraints(
            minWidth: 42,
            minHeight: 42,
          ),
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              if (widget.termId != null) {
                dispatcher.dispatch(RequestUpdateUserTermAction(
                  term: TermDto(
                    id: widget.termId,
                    name: _termController.text,
                    setId: widget.setId,
                    definition: _definitionController.text,
                  ),
                ));
              } else {
                dispatcher.dispatch(RequestAddUserTermAction(
                  term: TermDto(
                    id: 0,
                    name: _termController.text,
                    setId: widget.setId,
                    definition: _definitionController.text,
                  ),
                ));
              }

              Navigator.of(context).pop();
            }
          },
          child: Text(
            'Сохранить',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: VockifyColors.white,
                  fontSize: 18,
                ),
          ),
          padding: EdgeInsets.all(16),
        ),
      ],
      body: UserTermFormWidget(
        formKey: _formKey,
        termController: _termController,
        definitionController: _definitionController,
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
      final store = StoreProvider.of<AppState>(context, listen: false);
      final term = getTermById(store.state, widget.termId);

      if (term != null) {
        _termController.text = term.name;
        _definitionController.text = term.definition;
      }
    }

    super.initState();
  }
}
