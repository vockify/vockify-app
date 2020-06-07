import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/api/dto/set_dto.dart';
import 'package:vockify/src/redux/actions/request_add_set_action.dart';
import 'package:vockify/src/redux/actions/request_update_set_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/common/app_button_bar.dart';

class SetWidget extends StatefulWidget {
  final int setId;

  SetWidget(this.setId);

  @override
  State<StatefulWidget> createState() => _SetState();
}

class _SetState extends State<SetWidget> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final title = widget.setId != null ? 'ИЗМЕНИТЬ СЛОВАРЬ' : 'ДОБАВИТЬ СЛОВАРЬ';

    return AppLayoutWidget(
      title: title,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return StoreConnector<AppState, void>(
              distinct: true,
              onInit: (store) {
                if (widget.setId != null) {
                  final term = store.state.sets.firstWhere(
                    (item) => item.id == widget.setId,
                    orElse: () => null,
                  );

                  _nameController.text = term.name;
                }
              },
              converter: (store) => null,
              builder: (context, _) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    _formField("НАЗВАНИЕ", _nameController),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          _buildButtonBar(context),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  Widget _buildButtonBar(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return AppButtonBarWidget(
      children: [
        RaisedButton(
          shape: Border(),
          color: VockifyColors.grey,
          child: Text(
            "ОТМЕНИТЬ",
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: VockifyColors.prussianBlue,
                  fontSize: 16,
                ),
          ),
          onPressed: () => store.dispatch(NavigateToAction.pop()),
        ),
        RaisedButton(
          shape: Border(),
          color: VockifyColors.fulvous,
          child: Text(
            "СОХРАНИТЬ",
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: VockifyColors.white,
                  fontSize: 16,
                ),
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              final setDto = SetDto(widget.setId != null ? widget.setId : 0, _nameController.text, 'empty');

              if (setDto.id > 0) {
                store.dispatch(RequestUpdateSetAction(setDto));
              } else {
                store.dispatch(RequestAddSetAction(setDto));
              }

              store.dispatch(NavigateToAction.pop());
            }
          },
        ),
      ],
    );
  }

  Widget _formField(String labelText, TextEditingController controller) {
    return TextFormField(
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
