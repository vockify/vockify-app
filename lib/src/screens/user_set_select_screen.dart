import 'package:flutter/material.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/api/dto/terms/term_dto.dart';
import 'package:vockify/src/redux/actions/terms/request_add_user_term_action.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/add_user_term/user_set_select_list.dart';
import 'package:vockify/src/widgets/layout.dart';

class UserSetSelectScreenWidget extends StatefulWidget {
  final String term;
  final String definition;

  const UserSetSelectScreenWidget({
    Key key,
    @required this.term,
    @required this.definition,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserSetSelectScreenState();
}

class _UserSetSelectScreenState extends State<UserSetSelectScreenWidget> {
  int _selectedSetId;

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      route: Routes.userSetSelect,
      body: UserSetSelectListWidget(
        selectedSetId: _selectedSetId,
        onSelect: _onSelect,
      ),
    );
  }

  void _onSelect(int id) {
    setState(() {
      _selectedSetId = id;
    });

    dispatcher.dispatch(NavigateToAction.pop());

    dispatcher.dispatch(
      RequestAddUserTermAction(
        term: TermDto(
          id: 0,
          name: widget.term,
          definition: widget.definition,
          setId: _selectedSetId,
        ),
      ),
    );
  }
}
