import 'package:flutter/cupertino.dart';
import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';

class SetTermsLoaderAction extends AppAction {
  final LoaderState state;

  SetTermsLoaderAction({@required this.state});
}
