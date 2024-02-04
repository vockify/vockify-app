import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/models/home_item.dart';
import 'package:vockify/src/navigation/navigation_holder.dart';
import 'package:vockify/src/pages/terms/widgets/user_terms_bottom_sheet.dart';
import 'package:vockify/src/pages/terms/widgets/user_term_list.dart';
import 'package:vockify/src/models/app_model.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/app_bar_action.dart';
import 'package:vockify/src/widgets/home.dart';
import 'package:vockify/src/widgets/layout.dart';

class UserTermsPageWidget extends StatelessWidget {
  final int setId;

  UserTermsPageWidget({required this.setId});

  @override
  Widget build(BuildContext context) {
    final setsState = Provider.of<AppModel>(context, listen: false);
    final set = setsState.state.sets[setId]!;

    final name = context.select<AppModel, String?>(
      (value) => value.state.sets[setId]?.name,
    );

    return LayoutWidget(
      title: name,
      actions: <Widget>[
        AppBarAction(
          icon: FaIcon(
            FontAwesomeIcons.ellipsisVertical,
            color: VockifyColors.prussianBlue,
          ),
          onPressed: () {
            if (NavigatorHolder.navigatorKey.currentContext != null) {
              showModalBottomSheet<UserTermsBottomSheet>(
                context: NavigatorHolder.navigatorKey.currentContext!,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (BuildContext context) => Provider.value(
                  value: setsState,
                  builder: (context, value) {
                    return UserTermsBottomSheet(
                      setId: set.id,
                      onDelete: () {
                        final state =
                            NavigatorSettings[HomeItem.main]!.key.currentState!;
                        Navigator.of(state.context).pop();
                      },
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
      body: UserTermListWidget(
        setId: set.id,
      ),
    );
  }
}
