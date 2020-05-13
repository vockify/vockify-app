import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/term_dto.dart';
import 'package:vockify/src/api/dto/translate_request_dto.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/terms.dart';
import 'package:vockify/src/widgets/view_model/term_modal_view_model.dart';

class TermWidget extends StatefulWidget {
  static const String route = '/term';

  final int setId;
  final _definitionController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  TermWidget(this.setId);

  @override
  State<StatefulWidget> createState() => _TermState(setId.toString());

  void dispose() {
    _definitionController.dispose();
    _nameController.dispose();
  }
}

class _TermState extends State<TermWidget> {
  bool isLoading = false;
  String selectedSet;

  _TermState(this.selectedSet);

  Widget _setsList(BuiltList<SetState> sets) {
    return DropdownButton<String>(
      value: selectedSet,
      icon: Icon(Icons.arrow_downward),
      isExpanded: true,
      iconSize: 24,
      elevation: 16,
      underline: Container(
        height: 2,
        color: Colors.amber,
      ),
      onChanged: (String newValue) {
        setState(() {
          selectedSet = newValue;
        });
      },
      items: sets.map((set) {
        return DropdownMenuItem<String>(
          value: set.id.toString(),
          child: Text(set.name),
        );
      }).toList(),
    );
  }

  Widget _translateButton() {
    if (isLoading) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
      );
    }

    return RaisedButton(
      child: Text('TRANSLATE'),
      color: Colors.orange,
      onPressed: () async {
        if (widget._nameController.text.isEmpty) {
          return;
        }

        try {
          setState(() {
            isLoading = true;
          });

          final data = await api
              .translate(TranslateRequestDto([widget._nameController.text]));

          if (data.data.isNotEmpty) {
            widget._definitionController.text = data.data.first.text;
          }
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }

  Widget _submitButton(TermModalViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.orange,
        onPressed: () {
          if (widget._formKey.currentState.validate()) {
            viewModel.requestAddTerm(TermDto(
              0,
              widget._nameController.text,
              widget._definitionController.text,
              int.parse(selectedSet),
            ));
            viewModel.close(int.parse(selectedSet));
          }
        },
        child: Text('SAVE'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppLayoutWidget(
      title: 'Term form',
      redirectBackRoute: TermsWidget.route,
      redirectBackArguments: widget.setId,
      body: Center(
        child: StoreConnector<AppState, TermModalViewModel>(
          distinct: true,
          converter: (store) {
            return TermModalViewModel.fromStore(store);
          },
          builder: (context, viewModel) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Form(
                key: widget._formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _setsList(viewModel.sets),
                    Container(
                      alignment: Alignment.topCenter,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some name';
                          }
                          return null;
                        },
                        controller: widget._nameController,
                        decoration: InputDecoration(labelText: 'Name:'),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: _translateButton(),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some definition';
                          }
                          return null;
                        },
                        controller: widget._definitionController,
                        decoration: InputDecoration(labelText: 'Definition:'),
                      ),
                    ),
                    _submitButton(viewModel),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
