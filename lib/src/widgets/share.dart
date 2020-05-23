import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/term_dto.dart';
import 'package:vockify/src/api/dto/translate_request_dto.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/common/app_button_bar.dart';
import 'package:vockify/src/widgets/view_model/term_view_model.dart';

class ShareWidget extends StatefulWidget {
  final String term;

  ShareWidget(this.term);

  @override
  State<StatefulWidget> createState() => _ShareState(term);
}

class _ShareState extends State<ShareWidget> {
  final _definitionController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _selectedSetId;

  final String term;

  _ShareState(this.term);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context, listen: false);

    if (store.state.sets.isEmpty) {
      return AppLayoutWidget(
        title: 'ADD TERM',
        body: Center(
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
                  final store = StoreProvider.of<AppState>(context);
                  store.dispatch(NavigateToAction.replace(Routes.set));
                },
                child: Text('CREATE SET'),
              )
            ],
          ),
        ),
      );
    }

    return AppLayoutWidget(
      title: 'ADD TERM',
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return StoreConnector<AppState, TermViewModel>(
              distinct: true,
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
                              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    _buildSetsDropdown(viewModel.sets),
                                    Padding(padding: EdgeInsets.only(top: 20)),
                                    _buildFormField("NAME", _nameController),
                                    Padding(padding: EdgeInsets.only(top: 20)),
                                    _buildFormField("DEFINITION", _definitionController),
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

  @override
  void initState() {
    super.initState();

    final store = StoreProvider.of<AppState>(context, listen: false);

    _selectedSetId = store.state.sets.first.id;
    _nameController.text = term;

    api.translate(TranslateRequestDto([_nameController.text])).then((value) {
      if (value.data.isNotEmpty) {
        _definitionController.text = value.data.first.text;
      }
    });
  }

  Widget _buildButtonBar(TermViewModel viewModel, BuildContext context) {
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
          onPressed: viewModel.navigateBack,
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

              viewModel.requestSaveTerm(termDto);
              viewModel.navigateBack();
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

  Widget _buildSetsDropdown(BuiltList<SetState> sets) {
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
          value: _selectedSetId,
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
