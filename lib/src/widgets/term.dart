import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/term_dto.dart';
import 'package:vockify/src/api/dto/translate_request_dto.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state.dart';
import 'package:vockify/src/router/route_list.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/view_model/term_view_model.dart';

class TermWidget extends StatefulWidget {
  final int setId;
  final int termId;

  final _definitionController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  TermWidget(this.setId, this.termId);

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
        child: DropdownButton<String>(
          value: selectedSet,
          icon: Icon(Icons.arrow_downward),
          isExpanded: true,
          underline: Container(height: 0),
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
        ),
      ),
    );
  }

  Widget _formField(String labelText, TextEditingController controller, {Widget suffixIcon}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
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

  Widget _translateAddonButton() {
    if (isLoading) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.orange),
          strokeWidth: 3.0,
        ),
      );
    }

    return IconButton(
      onPressed: () async {
        if (widget._nameController.text.isEmpty) {
          return;
        }

        try {
          setState(() {
            isLoading = true;
          });

          final data = await api.translate(TranslateRequestDto([widget._nameController.text]));

          if (data.data.isNotEmpty) {
            widget._definitionController.text = data.data.first.text;
          }
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      },
      icon: Icon(Icons.translate),
    );
  }

  Widget _submitButton(TermViewModel viewModel, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: RaisedButton(
            shape: Border(),
            color: Colors.red,
            child: Text("CANCEL"),
            onPressed: viewModel.navigateBack,
          ),
        ),
        Expanded(
          child: RaisedButton(
            shape: Border(),
            color: Colors.orange,
            child: Text("SAVE"),
            onPressed: () {
              if (widget._formKey.currentState.validate()) {
                final termDto = TermDto(
                  widget.termId != null ? widget.termId : 0,
                  widget._nameController.text,
                  widget._definitionController.text,
                  int.parse(selectedSet),
                );

                viewModel.requestSaveTerm(termDto);
                viewModel.navigateToTerms(selectedSet);
              }
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppLayoutWidget(
      title: 'Save Term',
      redirectBackRoute: RouteList.terms,
      redirectBackArguments: widget.setId,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return StoreConnector<AppState, TermViewModel>(
              distinct: true,
              onInit: (store) {
                if (widget.termId != null) {
                  final term = store.state.terms.firstWhere(
                    (item) => item.id == widget.termId,
                    orElse: () => null,
                  );

                  widget._nameController.text = term.name;
                  widget._definitionController.text = term.definition;
                  selectedSet = term.setId.toString();
                }
              },
              converter: (store) {
                return TermViewModel.fromStore(store);
              },
              builder: (context, viewModel) {
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
                                key: widget._formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    _setsList(viewModel.sets),
                                    Padding(padding: EdgeInsets.only(top: 20)),
                                    _formField("Name", widget._nameController),
                                    Padding(padding: EdgeInsets.only(top: 20)),
                                    _formField(
                                      "Definition",
                                      widget._definitionController,
                                      suffixIcon: _translateAddonButton(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            child: _submitButton(viewModel, context),
                          )
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
}
