import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vockify/src/navigation/navigation_holder.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';
import 'package:vockify/src/widgets/user_term_item/user_term_bottom_sheet.dart';

class UserTermItemWidget extends StatelessWidget {
  final int id;
  final int setId;
  final VoidCallback onTap;

  const UserTermItemWidget({
    Key? key,
    required this.id,
    required this.onTap,
    required this.setId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TermState?>(
      distinct: true,
      converter: (store) => getTermById(store.state, id),
      builder: (context, term) {
        return Card(
          margin: EdgeInsets.only(bottom: 24),
          elevation: 2,
          child: ListTile(
            onTap: onTap,
            minVerticalPadding: 14,
            trailing: IconButton(
              onPressed: () {
                if (NavigatorHolder.navigatorKey.currentContext != null) {
                  showModalBottomSheet<UserTermBottomSheet>(
                    context: NavigatorHolder.navigatorKey.currentContext!,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (BuildContext context) {
                      return UserTermBottomSheet(setId: setId, id: id);
                    },
                  );
                }
              },
              icon: FaIcon(FontAwesomeIcons.ellipsis),
            ),
            title: Text(
              term?.name ?? '',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                term?.definition ?? '',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        );
      },
    );
  }
}
