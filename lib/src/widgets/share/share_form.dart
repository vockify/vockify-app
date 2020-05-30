import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/term_dto.dart';
import 'package:vockify/src/api/dto/translate_request_dto.dart';
import 'package:vockify/src/redux/actions/request_add_term_action.dart';
import 'package:vockify/src/redux/actions/request_update_term_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/common/app_button_bar.dart';

class ShareFormWidget extends StatefulWidget {
  final String term;

  ShareFormWidget(this.term);

  @override
  State<StatefulWidget> createState() => _ShareFormState(term);
}

class _ShareFormState extends State<ShareFormWidget> {
  final _definitionController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _selectedSetId;

  final String term;

  Store<AppState> _store;

  _ShareFormState(this.term);

  @override
  Widget build(BuildContext context) {
    if (_store.state.sets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'First you need to create a set',
              style: Theme.of(context).textTheme.headline4,
            ),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            FlatButton(
              color: VockifyColors.fulvous,
              textColor: VockifyColors.white,
              onPressed: () {
                _store.dispatch(NavigateToAction.replace(Routes.set));
              },
              child: Text('CREATE SET'),
            )
          ],
        ),
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
                  _buildSetsDropdown(_selectedSetId, _store.state.sets),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  _buildFormField("NAME", _nameController),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  _buildFormField("DEFINITION", _definitionController),
                ],
              ),
            ),
          ),
        ),
        _buildButtonBar(context),
      ],
    );
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

    if (_store.state.sets.isNotEmpty) {
      _selectedSetId = _store.state.sets.first.id;
      _nameController.text = term;

      api.translate(TranslateRequestDto([_nameController.text])).then((value) {
        if (value.data.isNotEmpty) {
          _definitionController.text = value.data.first.text;
        }
      });
    }
  }

  Widget _buildButtonBar(BuildContext context) {
    return AppButtonBarWidget(
      children: [
        RaisedButton(
          shape: Border(),
          color: VockifyColors.grey,
          child: Text(
            "CANCEL",
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: VockifyColors.prussianBlue,
                  fontSize: 16,
                ),
          ),
          onPressed: () => _store.dispatch(NavigateToAction.pop()),
        ),
        RaisedButton(
          shape: Border(),
          color: VockifyColors.fulvous,
          child: Text(
            "SAVE",
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

              _store.dispatch(NavigateToAction.pop());
            }
          },
        ),
      ],
    );
  }

  Widget _buildFormField(String labelText, TextEditingController controller) {
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
          return 'The value is required';
        }

        return null;
      },
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildSetsDropdown(int setId, BuiltList<SetState> sets) {
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
}
