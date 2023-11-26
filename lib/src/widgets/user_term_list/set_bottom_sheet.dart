import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vockify/src/models/home_item.dart';
import 'package:vockify/src/navigation/navigate_to_action.dart';
import 'package:vockify/src/redux/actions/sets/request_remove_user_set_action.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/home.dart';

enum AppBottomSheetSelecteItem {
  setForm,
  setList,
}

class SetBottomSheet extends StatefulWidget {
  final int setId;

  const SetBottomSheet({super.key, required this.setId});

  @override
  State<StatefulWidget> createState() => _SetBottomSheet();
}

class _SetBottomSheet extends State<SetBottomSheet> {
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
    return Column(
      mainAxisSize: MainAxisSize.min,
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
                  dispatcher.dispatch(
                    NavigateToAction.pop(),
                  );
                  dispatcher.dispatch(
                    NavigateToAction.push(
                      Routes.userTerm,
                      arguments: {'setId': widget.setId},
                      currentState: NavigatorSettings[HomeItem.main]?.key.currentState,
                    ),
                  );
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
                    ),
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
                fillColor: VockifyColors.flame,
                onPressed: () {
                  dispatcher.dispatch(RequestRemoveUserSetAction(id: widget.setId));
                  dispatcher.dispatch(NavigateToAction.pushNamedAndRemoveUntil(
                    Routes.main,
                    (route) => false,
                    currentState: NavigatorSettings[HomeItem.main]?.key.currentState,
                  ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.trashCan,
                      color: VockifyColors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Удалить словарь',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
