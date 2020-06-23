import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/unauthorize_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/user_state/user_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_layout.dart';

class ProfilePageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppLayoutWidget(
      route: Routes.profile,
      actions: <Widget>[
        RawMaterialButton(
          constraints: BoxConstraints(
            minWidth: 42,
            minHeight: 42,
          ),
          onPressed: () {
            final store = StoreProvider.of<AppState>(context, listen: false);
            store.dispatch(UnauthorizeAction());
          },
          child: Icon(
            Icons.exit_to_app,
            color: VockifyColors.white,
          ),
          padding: EdgeInsets.all(16),
          shape: CircleBorder(),
        ),
      ],
      body: Center(
        child: StoreConnector<AppState, UserState>(
          distinct: true,
          converter: (store) => store.state.user,
          builder: (context, user) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (user.avatar != null) Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(user.avatar)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: ListTile(
                    title: Center(
                      child: Text(
                        '${user.firstName} ${user.lastName}',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    subtitle: Text(
                      user.email,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
