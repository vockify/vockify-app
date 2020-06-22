import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/api/dto/set_dto.dart';
import 'package:vockify/src/redux/actions/request_add_set_action.dart';
import 'package:vockify/src/redux/actions/request_update_set_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_layout.dart';

class SetPageWidget extends StatefulWidget {
  final int setId;

  SetPageWidget({
    @required this.setId,
  });

  @override
  State<StatefulWidget> createState() => _SetPageState();
}

class _SetPageState extends State<SetPageWidget> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return AppLayoutWidget(
      route: Routes.set,
      actions: <Widget>[
        RawMaterialButton(
          constraints: BoxConstraints(
            minWidth: 42,
            minHeight: 42,
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              final setDto = SetDto(widget.setId != null ? widget.setId : 0, _nameController.text, 'empty');

              if (setDto.id > 0) {
                store.dispatch(RequestUpdateSetAction(setDto));
              } else {
                store.dispatch(RequestAddSetAction(setDto));
              }

              Navigator.of(context).pop();
            }
          },
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
              _buildTextFormField("НАЗВАНИЕ", _nameController),
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
    super.initState();

    final store = StoreProvider.of<AppState>(context, listen: false);

    if (widget.setId != null) {
      final term = store.state.sets.firstWhere(
        (item) => item.id == widget.setId,
        orElse: () => null,
      );

      _nameController.text = term.name;
    }
  }

  Widget _buildTextFormField(String labelText, TextEditingController controller) {
    return TextFormField(
      autofocus: true,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        fillColor: VockifyColors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'ОБЯЗАТЕЛЬНОЕ ПОЛЕ';
        }

        return null;
      },
      keyboardType: TextInputType.text,
    );
  }
}
