import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/widgets/common/loader.dart';
import 'package:vockify/src/widgets/pages/login/login_page_view_model.dart';

class LoginPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VOCKIFY'),
      ),
      body: Center(
        child: StoreConnector<AppState, LoginPageViewModel>(
          distinct: true,
          converter: (store) => LoginPageViewModel.fromStore(store),
          builder: (context, viewModel) {
            if (viewModel.isLoading) {
              return LoaderWidget();
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'Чтобы пользоваться всеми функциями приложения, вам необходимо авторизоваться.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: viewModel.requestAuthorize,
                  child: Image.asset(
                    'assets/btn_google_signin_dark_normal_web@2x.png',
                    width: 240,
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
