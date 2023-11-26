import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vockify/src/models/home_item.dart';
import 'package:vockify/src/redux/actions/set_bottom_navidation_item_index.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/home_bottom_sheet.dart';
import 'package:vockify/src/widgets/home.dart';

class VockifyBottomNavigationBar extends StatelessWidget {
  final HomeItem currentItem;

  VockifyBottomNavigationBar({required this.currentItem});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: VockifyColors.white,
      height: 76,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => _goToItem(HomeItem.start),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: VockifyColors.prussianBlue,
                        size: currentItem == HomeItem.start ? 28 : 24,
                      ),
                      Divider(
                        height: 2,
                      ),
                      Text(
                        "Поиск",
                        style: TextStyle(
                          fontWeight: currentItem == HomeItem.start ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 70,
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (BuildContext context) {
                      return HomeBottomSheet(onSetCreate: () {
                        _goToItem(HomeItem.main);
                      });
                    },
                  );
                },
                child: FaIcon(
                  FontAwesomeIcons.circlePlus,
                  size: 40,
                  color: VockifyColors.fulvous,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => _goToItem(HomeItem.main),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.book,
                        color: VockifyColors.prussianBlue,
                        size: currentItem == HomeItem.main ? 28 : 24,
                      ),
                      Divider(
                        height: 2,
                      ),
                      Text(
                        "Словари",
                        style: TextStyle(
                          fontWeight: currentItem == HomeItem.main ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _goToItem(HomeItem item) {
    if (NavigatorSettings.containsKey(item)) {
      final settings = NavigatorSettings[item];
      settings?.key.currentState?.popUntil((route) => route.settings.name == settings.initialRoute);
    }

    dispatcher.dispatch(SetBottomNavigationItemIndex(index: item));
  }
}
