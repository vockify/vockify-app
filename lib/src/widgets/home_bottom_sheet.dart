import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/models/app_model.dart';
import 'package:vockify/src/models/bar_model.dart';
import 'package:vockify/src/models/home_item.dart';
import 'package:vockify/src/models/set_model/set_model.dart';
import 'package:vockify/src/models/terms_model/terms_model.dart';
import 'package:vockify/src/pages/term/user_term_page.dart';
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
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
    final appModel = context.read<AppModel>();
    final setIds = appModel.getUserSetIds();

    final barModel = context.read<BarModel>();

    return Container(
      child: Column(
        children: [
          Text('Выберите словарь'),
          Expanded(
            child: ListView.builder(
              itemCount: setIds.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final id = setIds[index];
                final set = appModel.state.sets[id]!;

                return Column(
                  children: [
                    ListTile(
                      title: Text(set.name),
                      onTap: () {
                        Navigator.of(context).pop();
                        barModel.setCurrentItem(HomeItem.main);
                        Navigator.of(NavigatorSettings[HomeItem.main]!
                                .key
                                .currentContext!)
                            .push(
                          MaterialPageRoute<UserTermPageWidget>(
                              builder: (context) {
                            return UserTermPageWidget(setId: set.id);
                          }),
                        );
                      },
                    ),
                    Divider(
                      height: 0,
                      thickness: 1,
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSetForm() {
    final appModel = context.read<AppModel>();

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
              appModel.addSet(
                SetModel(
                  id: 0,
                  name: _nameController.text,
                  isDefault: false,
                  terms: TermsModel(
                    ids: [],
                    terms: {},
                  ),
                ),
              );

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
