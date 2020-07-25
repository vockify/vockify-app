import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/terms/term_dto.dart';
import 'package:vockify/src/api/dto/translate/translate_request_dto.dart';
import 'package:vockify/src/redux/actions/sets/request_user_sets_action.dart';
import 'package:vockify/src/redux/actions/terms/request_add_user_term_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/services/app_storage/app_storage.dart';
import 'package:vockify/src/services/app_storage/app_storage_key.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/empty.dart';
import 'package:vockify/src/widgets/common/form_dropdown.dart';
import 'package:vockify/src/widgets/common/form_text_field.dart';
import 'package:vockify/src/widgets/layout.dart';

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

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      route: Routes.share,
      isContextNavigation: false,
      redirectBackRoute: Routes.home,
      isLoading: (store) => getUserSetLoader(store.state) == LoaderState.isLoading,
      actions: <Widget>[
        RawMaterialButton(
          constraints: BoxConstraints(
            minWidth: 42,
            minHeight: 42,
          ),
          onPressed: () {
            _onSave();
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
      body: StoreConnector<AppState, Iterable<SetState>>(
        distinct: true,
        converter: (store) => getSetItems(store.state).values,
        builder: (context, sets) {
          if (sets.isEmpty) {
            return EmptyWidget(
              text: 'Для начала вам необходимо создать новый словарь',
              buttonText: 'СОЗДАТЬ СЛОВАРЬ',
              onPressed: () => dispatcher.dispatch(NavigateToAction.replace(Routes.home)),
            );
          }

          _selectedSetId = _selectedSetId ?? sets.first.id;

          return Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FormDropdownWidget(
                    items: sets.map((set) => FormDropdownItem(set.id, set.name)),
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
                    autoFocus: true,
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
      _definitionController.text = value.data.first.text;
    });

    AppStorage.getInstance().getValue(AppStorageKey.selectedSetId).then((value) {
      setState(() {
        _selectedSetId = int.tryParse(value ?? '');
      });
    });
  }

  void _onSave() {
    if (_formKey.currentState.validate()) {
      AppStorage.getInstance().setValue(AppStorageKey.selectedSetId, _selectedSetId.toString());

      dispatcher.dispatch(RequestAddUserTermAction(
        term: TermDto(
          id: 0,
          name: _nameController.text,
          setId: _selectedSetId,
          definition: _definitionController.text,
        ),
      ));

      SystemNavigator.pop();
    }
  }
}
