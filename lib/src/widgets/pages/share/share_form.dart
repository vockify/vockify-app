import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/api/dto/term_dto.dart';
import 'package:vockify/src/redux/actions/request_add_term_action.dart';
import 'package:vockify/src/redux/actions/request_update_term_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/services/app_storage/app_storage.dart';
import 'package:vockify/src/services/app_storage/app_storage_key.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/common/app_button_bar.dart';
import 'package:vockify/src/widgets/common/empty.dart';

class ShareFormWidget extends StatefulWidget {
  final String term;
  final String definition;
  final Iterable<SetState> sets;

  ShareFormWidget({this.term, this.sets, this.definition});

  @override
  State<StatefulWidget> createState() => _ShareFormState();
}

class _ShareFormState extends State<ShareFormWidget> {
  final _definitionController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _selectedSetId;

  Store<AppState> _store;

  @override
  Widget build(BuildContext context) {
    if (widget.sets.isEmpty) {
      return EmptyWidget(
        text: 'Для начала вам необходимо создать новый словарь',
        buttonText: 'СОЗДАТЬ СЛОВАРЬ',
        onPressed: () => _store.dispatch(NavigateToAction.replace(Routes.set)),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildSetsDropdownButton(_selectedSetId, widget.sets),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  _buildTextFormField("СЛОВО", _nameController),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  _buildTextFormField("ПЕРЕВОД", _definitionController),
                ],
              ),
            ),
          ),
        ),
        _buildAppButtonBar(context),
      ],
    );
  }

  @override
  void didUpdateWidget(ShareFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    _update();
  }

  @override
  void dispose() {
    super.dispose();
    _definitionController.dispose();
    _nameController.dispose();
  }

  @override
  void initState() {
    super.initState();

    _store = StoreProvider.of<AppState>(context, listen: false);
    _update();
  }

  Widget _buildAppButtonBar(BuildContext context) {
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
          onPressed: () {
            SystemNavigator.pop();
          },
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
              final termDto = TermDto(
                0,
                _nameController.text,
                _definitionController.text,
                _selectedSetId,
              );

              if (termDto.id > 0) {
                _store.dispatch(RequestUpdateTermAction(termDto));
              } else {
                _store.dispatch(RequestAddTermAction(termDto));
              }

              SystemNavigator.pop();

              AppStorage.getInstance().setValue(AppStorageKey.selectedSetId, _selectedSetId.toString());
            }
          },
        ),
      ],
    );
  }

  Widget _buildSetsDropdownButton(int setId, Iterable<SetState> sets) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        border: Border.fromBorderSide(
          BorderSide(color: Colors.grey),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: DropdownButton<int>(
          value: setId,
          icon: Icon(Icons.arrow_downward),
          isExpanded: true,
          underline: Container(height: 0),
          onChanged: (value) {
            setState(() {
              _selectedSetId = value;
            });
          },
          items: sets.map((set) {
            return DropdownMenuItem<int>(
              value: set.id,
              child: Text(set.name),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String labelText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        fillColor: Colors.white,
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

  void _update() {
    if (widget.sets.isNotEmpty) {
      _selectedSetId = _selectedSetId ?? _store.state.selectedSetId ?? _store.state.sets.first.id;
      _nameController.text = widget.term;
      _definitionController.text = widget.definition;
    }
  }
}
