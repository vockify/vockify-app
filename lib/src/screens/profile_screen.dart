import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/auth/request_authorize_action.dart';
import 'package:vockify/src/redux/actions/auth/unauthorize_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/user_state/user_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/layout.dart';

class ProfileScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      route: Routes.profile,
      actions: <Widget>[
        StoreConnector<AppState, UserState>(
          distinct: true,
          converter: (store) => getUserState(store.state),
          builder: (context, user) {
            if (user.isRegistered) {
              return RawMaterialButton(
                constraints: BoxConstraints(
                  minWidth: 42,
                  minHeight: 42,
                ),
                onPressed: () {
                  dispatcher.dispatch(UnauthorizeAction());
                },
                child: Icon(
                  Icons.exit_to_app,
                  color: VockifyColors.white,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              );
            }

            return Container();
          },
        ),
      ],
      body: Center(
        child: StoreConnector<AppState, UserState>(
          distinct: true,
          converter: (store) => getUserState(store.state),
          builder: (context, user) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (user.avatar != null)
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(user.avatar)),
                    ),
                  ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: _buildContent(context, user),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, UserState user) {
    if (user.isRegistered) {
      return ListTile(
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
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            dispatcher.dispatch(RequestAuthorizeAction());
          },
          child: Image.asset(
            'assets/btn_google_signin_dark_normal_web@2x.png',
            width: 240,
          ),
        ),
      ],
    );
  }
}
