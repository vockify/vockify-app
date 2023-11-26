import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vockify/src/navigation/navigation_holder.dart';
import 'package:vockify/src/redux/actions/terms/request_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/unset_terms_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/app_bar_action.dart';
import 'package:vockify/src/widgets/layout.dart';
import 'package:vockify/src/widgets/user_term_list/set_bottom_sheet.dart';
import 'package:vockify/src/widgets/user_term_list/user_term_list.dart';

class UserTermsScreenWidget extends StatelessWidget {
  final int setId;

  UserTermsScreenWidget({required this.setId});

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final set = getSetById(store.state, setId);

    return LayoutWidget(
      route: Routes.userTerms,
      title: set?.name,
      actions: <Widget>[
        AppBarAction(
          icon: FaIcon(
            FontAwesomeIcons.ellipsisVertical,
            color: VockifyColors.prussianBlue,
          ),
          onPressed: () {
            if (NavigatorHolder.navigatorKey.currentContext != null) {
              showModalBottomSheet<SetBottomSheet>(
                context: NavigatorHolder.navigatorKey.currentContext!,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (BuildContext context) => SetBottomSheet(
                  setId: setId,
                ),
              );
            }
          },
        ),
      ],
      onInit: (store) {
        store.dispatch(RequestTermsAction(setId: setId));
      },
      onDispose: (store) {
        store.dispatch(UnsetTermsAction());
      },
      isLoading: (store) => getTermLoader(store.state) == LoaderState.isLoading,
      body: UserTermListWidget(setId),
    );
  }
}
