import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/api/dto/sets/set_dto.dart';
import 'package:vockify/src/redux/actions/sets/request_add_user_set_action.dart';
import 'package:vockify/src/redux/actions/sets/request_update_user_set_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/form_text_field.dart';
import 'package:vockify/src/widgets/layout.dart';

class SetScreenWidget extends StatefulWidget {
  final int setId;

  SetScreenWidget({
    @required this.setId,
  });

  @override
  State<StatefulWidget> createState() => _SetScreenState();
}

class _SetScreenState extends State<SetScreenWidget> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      route: Routes.userSet,
      actions: <Widget>[
        RawMaterialButton(
          constraints: BoxConstraints(
            minWidth: 42,
            minHeight: 42,
          ),
          onPressed: _onSave,
          child: Text(
            'Сохранить',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: VockifyColors.white,
                  fontSize: 18,
                ),
          ),
          padding: EdgeInsets.all(16),
        ),
      ],
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FormTextFieldWidget(
                controller: _nameController,
                text: 'НАЗВАНИЕ',
                autoFocus: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  void initState() {
    final store = StoreProvider.of<AppState>(context, listen: false);

    if (widget.setId != null) {
      final set = getSetById(store.state, widget.setId);
      _nameController.text = set.name;
    }

    super.initState();
  }

  void _onSave() {
    if (_formKey.currentState.validate()) {
      if (widget.setId != null) {
        dispatcher.dispatch(RequestUpdateUserSetAction(
          set: SetDto(
            id: widget.setId,
            name: _nameController.text,
          ),
        ));
      } else {
        dispatcher.dispatch(RequestAddUserSetAction(
          set: SetDto(
            id: 0,
            name: _nameController.text,
          ),
        ));
      }

      Navigator.of(context).pop();
    }
  }
}
