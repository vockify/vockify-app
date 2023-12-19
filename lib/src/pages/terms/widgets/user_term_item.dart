import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/models/term_model/term_model.dart';
import 'package:vockify/src/navigation/navigation_holder.dart';
import 'package:vockify/src/pages/terms/widgets/user_term_bottom_sheet.dart';
import 'package:vockify/src/pages/term/user_term_page.dart';
import 'package:vockify/src/models/app_model.dart';

class UserTermItemWidget extends StatelessWidget {
  final int setId;
  final int termId;

  const UserTermItemWidget({
    required this.setId,
    required this.termId,
  });

  @override
  Widget build(BuildContext context) {
    final term = context.select<AppModel, TermModel?>((value) {
      return value.state.sets[setId]!.terms.terms[termId];
    });

    if (term == null) {
      return Container();
    }

    final setsState = context.read<AppModel>();

    return Card(
      margin: EdgeInsets.only(bottom: 24),
      elevation: 2,
      child: ListTile(
        onTap: () {
          if (NavigatorHolder.navigatorKey.currentContext != null) {
            Navigator.of(NavigatorHolder.navigatorKey.currentContext!).push(
              MaterialPageRoute<UserTermPageWidget>(
                builder: (context) {
                  return UserTermPageWidget(
                    setId: setId,
                    termId: termId,
                  );
                },
              ),
            );
          }
        },
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
                  return UserTermBottomSheet(
                    id: term.id,
                    onDelete: () {
                      Navigator.of(context).pop();
                      setsState.removeTerm(setId, term.id);
                    },
                  );
                },
              );
            }
          },
          icon: FaIcon(FontAwesomeIcons.ellipsis),
        ),
        title: Text(
          term.name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            term.definition,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
