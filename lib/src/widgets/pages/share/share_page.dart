import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/translate_request_dto.dart';
import 'package:vockify/src/redux/actions/terms/request_add_term_action.dart';
import 'package:vockify/src/redux/actions/sets/request_user_sets_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/services/app_storage/app_storage.dart';
import 'package:vockify/src/services/app_storage/app_storage_key.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/common/empty.dart';
import 'package:vockify/src/widgets/common/form_dropdown.dart';
import 'package:vockify/src/widgets/common/form_text_field.dart';
import 'package:vockify/src/widgets/pages/share/share_page_view_model.dart';

class SharePageWidget extends StatefulWidget {
  final String term;

  SharePageWidget({
    @required this.term,
  });

  @override
  State<StatefulWidget> createState() => _ShareFormState();
}

class _ShareFormState extends State<SharePageWidget> {
  final _definitionController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _selectedSetId;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return AppLayoutWidget(
      route: Routes.share,
      isContextNavigation: false,
      redirectBackRoute: Routes.home,
      actions: <Widget>[
        RawMaterialButton(
          constraints: BoxConstraints(
            minWidth: 42,
            minHeight: 42,
          ),
          onPressed: () {
            _onSave(store);
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
      onInit: (store) {
        store.dispatch(RequestUserSetsAction());
      },
      body: StoreConnector<AppState, SharePageViewModel>(
        distinct: true,
        converter: (store) => SharePageViewModel.fromStore(store),
        builder: (context, viewModel) {
          if (viewModel.sets.isEmpty) {
            return EmptyWidget(
              text: 'Для начала вам необходимо создать новый словарь',
              buttonText: 'СОЗДАТЬ СЛОВАРЬ',
              onPressed: () => store.dispatch(NavigateToAction.replace(Routes.home)),
            );
          }

          _selectedSetId = _selectedSetId ?? viewModel.selectedSetId ?? viewModel.sets.first.id;

          return Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FormDropdownWidget(
                    items: viewModel.sets.map((set) => FormDropdownItem(set.id, set.name)),
                    selectedId: _selectedSetId,
                    onChanged: (id) {
                      setState(() {
                        _selectedSetId = id;
                      });
                    },
                  ),
                  FormTextFieldWidget(
                    controller: _nameController,
                    text: 'СЛОВО НА АНГЛИЙСКОМ',
                  ),
                  FormTextFieldWidget(
                    controller: _definitionController,
                    text: 'ПЕРЕВОД',
                    autoFocus: _isFocused,
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
    super.dispose();
    _definitionController.dispose();
    _nameController.dispose();
  }

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.term;

    api.translate(TranslateRequestDto([widget.term])).then((value) {
      setState(() {
        _definitionController.text = value.data.first.text;
        _isFocused = true;
      });
    });
  }

  void _onSave(Store<AppState> store) {
    if (_formKey.currentState.validate()) {
      AppStorage.getInstance().setValue(AppStorageKey.selectedSetId, _selectedSetId.toString());

      store.dispatch(RequestAddTermAction(TermState((builder) {
        builder.id = 0;
        builder.name = _nameController.text;
        builder.definition = _definitionController.text;
        builder.setId = _selectedSetId;
      })));

      SystemNavigator.pop();
    }
  }
}
