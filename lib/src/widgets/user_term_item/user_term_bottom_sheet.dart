import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vockify/src/models/home_item.dart';
import 'package:vockify/src/navigation/navigate_to_action.dart';
import 'package:vockify/src/redux/actions/terms/request_remove_user_term_action.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/home.dart';

enum AppBottomSheetSelecteItem {
  setForm,
  setList,
}

class UserTermBottomSheet extends StatefulWidget {
  final int setId;
  final int id;

  const UserTermBottomSheet({super.key, required this.setId, required this.id});

  @override
  State<StatefulWidget> createState() => _UserTermBottomSheet();
}

class _UserTermBottomSheet extends State<UserTermBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: _buildMenu(),
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
                fillColor: VockifyColors.flame,
                onPressed: () {
                  dispatcher.dispatch(RequestRemoveUserTermAction(id: widget.id, setId: widget.setId));
                  dispatcher.dispatch(NavigateToAction.pop(
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
                      'Удалить термин',
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
