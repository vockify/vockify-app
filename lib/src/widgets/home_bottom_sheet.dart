import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/api/dto/sets/set_dto.dart';
import 'package:vockify/src/models/home_item.dart';
import 'package:vockify/src/navigation/navigate_to_action.dart';
import 'package:vockify/src/redux/actions/set_bottom_navidation_item_index.dart';
import 'package:vockify/src/redux/actions/sets/request_add_user_set_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/primary_text_form_field.dart';
import 'package:vockify/src/widgets/home.dart';

enum AppBottomSheetSelecteItem {
  setForm,
  setList,
}

class HomeBottomSheet extends StatefulWidget {
  final void Function() onSetCreate;

  HomeBottomSheet({required this.onSetCreate});

  @override
  State<StatefulWidget> createState() => _HomeBottomSheet();
}

class _HomeBottomSheet extends State<HomeBottomSheet> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AppBottomSheetSelecteItem? _selectedItem;

  double? _height = 150;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: AnimatedContainer(
          height: _height,
          curve: Curves.easeOutExpo,
          duration: Duration(milliseconds: 400),
          child: _buildMenu(),
        ),
      ),
    );
  }

  Widget _buildMenu() {
    if (_selectedItem == null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: RawMaterialButton(
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  fillColor: VockifyColors.fulvous,
                  onPressed: () {
                    setState(() {
                      _selectedItem = AppBottomSheetSelecteItem.setList;
                      // _height = 400;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.plus,
                        color: VockifyColors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Добавить термин',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RawMaterialButton(
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  fillColor: VockifyColors.fulvous,
                  onPressed: () {
                    setState(() {
                      _selectedItem = AppBottomSheetSelecteItem.setForm;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.folderPlus,
                        color: VockifyColors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Создать словарь',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return switch (_selectedItem) {
      AppBottomSheetSelecteItem.setForm => _buildSetForm(),
      AppBottomSheetSelecteItem.setList => _buildSetList(),
      null => Container()
    };
  }

  Widget _buildSetList() {
    return StoreConnector<AppState, List<int>>(
      distinct: true,
      converter: (Store<AppState> store) => store.state.sets.userSetIds.toList(),
      builder: (context, setIds) => Container(
        child: Column(
          children: [
            Text('Выберите словарь'),
            Expanded(
              child: ListView.builder(
                itemCount: setIds.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => StoreConnector<AppState, SetState?>(
                  converter: (Store<AppState> store) => store.state.sets.items[setIds[index]],
                  builder: (context, set) => Column(
                    children: [
                      ListTile(
                        title: Text(set?.name ?? ''),
                        onTap: () {
                          Navigator.of(context).pop();
                          dispatcher.dispatch(SetBottomNavigationItemIndex(index: HomeItem.main));
                          dispatcher.dispatch(
                            NavigateToAction.push(
                              Routes.userTerm,
                              arguments: {'setId': set?.id},
                              currentState: NavigatorSettings[HomeItem.main]?.key.currentState,
                            ),
                          );
                        },
                      ),
                      Divider(
                        height: 0,
                        thickness: 1,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSetForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PrimaryTextFormFieldWidget(
            controller: _nameController,
            label: 'НАЗВАНИЕ',
            autoFocus: true,
          ),
          RawMaterialButton(
            padding: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            fillColor: VockifyColors.persianGreen,
            onPressed: () {
              dispatcher.dispatch(RequestAddUserSetAction(
                set: SetDto(
                  id: 0,
                  name: _nameController.text,
                  isDefault: false,
                ),
              ));

              Navigator.pop(context);

              widget.onSetCreate();
            },
            child: Text(
              'Создать',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: VockifyColors.ghostWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
