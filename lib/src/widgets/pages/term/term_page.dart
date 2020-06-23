import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/translate_request_dto.dart';
import 'package:vockify/src/redux/actions/terms/request_add_user_term_action.dart';
import 'package:vockify/src/redux/actions/terms/request_update_term_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/common/form_dropdown.dart';
import 'package:vockify/src/widgets/common/form_text_field.dart';
import 'package:vockify/src/widgets/common/loader.dart';
import 'package:vockify/src/widgets/pages/term/term_page_view_model.dart';

class TermPageWidget extends StatefulWidget {
  final int setId;
  final int termId;

  TermPageWidget({
    @required this.setId,
    @required this.termId,
  });

  @override
  State<StatefulWidget> createState() => _TermPageState();
}

class _TermPageState extends State<TermPageWidget> {
  final _definitionController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  int _selectedSetId;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return AppLayoutWidget(
      route: Routes.term,
      actions: <Widget>[
        RawMaterialButton(
          constraints: BoxConstraints(
            minWidth: 42,
            minHeight: 42,
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              if (widget.termId > 0) {
                store.dispatch(RequestUpdateUserTermAction(TermState((builder) {
                  builder.id = widget.termId;
                  builder.name = _nameController.text;
                  builder.definition = _definitionController.text;
                  builder.setId = _selectedSetId;
                })));
              } else {
                store.dispatch(RequestAddUserTermAction(TermState((builder) {
                  builder.id = 0;
                  builder.name = _nameController.text;
                  builder.definition = _definitionController.text;
                  builder.setId = _selectedSetId;
                })));
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
      body: StoreConnector<AppState, TermPageViewModel>(
        distinct: true,
        onInit: (store) {
          if (widget.termId != null) {
            final term = store.state.terms.items[widget.termId];

            _nameController.text = term.name;
            _definitionController.text = term.definition;
            _selectedSetId = term.setId;
          }
        },
        converter: (store) {
          return TermPageViewModel.fromStore(store);
        },
        builder: (context, viewModel) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FormDropdownWidget(
                    selectedId: _selectedSetId,
                    items: viewModel.sets.map((set) => FormDropdownItem(set.id, set.name)),
                    onChanged: (value) {
                      setState(() {
                        _selectedSetId = value;
                      });
                    },
                  ),
                  FormTextFieldWidget(
                    controller: _nameController,
                    text: 'СЛОВО НА АНГЛИЙСКОМ',
                    autoFocus: true,
                  ),
                  FormTextFieldWidget(
                    controller: _definitionController,
                    text: 'ПЕРЕВОД',
                    suffix: _buildTranslateButton(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _definitionController.dispose();
    _nameController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _selectedSetId = widget.setId;

    super.initState();
  }

  Widget _buildTranslateButton() {
    if (_isLoading) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: LoaderWidget(),
      );
    }

    return IconButton(
      onPressed: () async {
        if (_nameController.text.isEmpty) {
          return;
        }

        setState(() {
          _isLoading = true;
        });

        try {
          final data = await api.translate(TranslateRequestDto([_nameController.text]));

          if (data.data.isNotEmpty) {
            _definitionController.text = data.data.first.text;
          }
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      },
      icon: Icon(Icons.translate),
    );
  }
}
