import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/term_dto.dart';
import 'package:vockify/src/api/dto/translate_request_dto.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/common/app_button_bar.dart';
import 'package:vockify/src/widgets/view_model/term_view_model.dart';

class TermWidget extends StatefulWidget {
  final int setId;
  final int termId;

  TermWidget(this.setId, this.termId);

  @override
  State<StatefulWidget> createState() => _TermState(setId.toString());
}

class _TermState extends State<TermWidget> {
  final _definitionController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String selectedSet;

  _TermState(this.selectedSet);

  @override
  Widget build(BuildContext context) {
    return AppLayoutWidget(
      title: widget.termId == null ? 'ДОБАВИТЬ СЛОВО' : 'ИЗМЕНИТЬ СЛОВО',
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

                  _nameController.text = term.name;
                  _definitionController.text = term.definition;
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
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    _setsList(viewModel.sets),
                                    Padding(padding: EdgeInsets.only(top: 20)),
                                    _formField("СЛОВО", _nameController),
                                    Padding(padding: EdgeInsets.only(top: 20)),
                                    _formField(
                                      "ЗНАЧЕНИЕ",
                                      _definitionController,
                                      suffixIcon: _translateAddonButton(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          _buildButtonBar(viewModel, context),
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
    _definitionController.dispose();
    _nameController.dispose();
  }

  Widget _buildButtonBar(TermViewModel viewModel, BuildContext context) {
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
          onPressed: viewModel.navigateBack,
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
                widget.termId != null ? widget.termId : 0,
                _nameController.text,
                _definitionController.text,
                int.parse(selectedSet),
              );

              viewModel.saveTerm(termDto);
              viewModel.navigateBack();
            }
          },
        ),
      ],
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
          return 'ОБЯЗАТЕЛЬНОЕ ПОЛЕ';
        }
        return null;
      },
      keyboardType: TextInputType.text,
    );
  }

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
        if (_nameController.text.isEmpty) {
          return;
        }

        try {
          setState(() {
            isLoading = true;
          });

          final data = await api.translate(TranslateRequestDto([_nameController.text]));

          if (data.data.isNotEmpty) {
            _definitionController.text = data.data.first.text;
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
}
