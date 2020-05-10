import 'package:vockify/src/api/dto/sets_response.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class OnSetsLoadedAction extends AppAction {
  final SetsResponse payload;
  
  OnSetsLoadedAction(this.payload);
}