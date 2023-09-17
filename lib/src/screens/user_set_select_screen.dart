import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vockify/src/api/dto/sets/set_filters_dto.dart';
import 'package:vockify/src/api/dto/terms/term_dto.dart';
import 'package:vockify/src/database/data_service.dart';
import 'package:vockify/src/navigation/navigate_to_action.dart';
import 'package:vockify/src/redux/actions/terms/request_add_user_term_action.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/services/amplitude.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/app_bar_action.dart';
import 'package:vockify/src/widgets/layout.dart';
import 'package:vockify/src/widgets/start_user_term_form/user_set_select_list.dart';

class UserSetSelectScreenWidget extends StatefulWidget {
  final String term;
  final String definition;

  const UserSetSelectScreenWidget({
    Key? key,
    required this.term,
    required this.definition,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserSetSelectScreenState();
}

class _UserSetSelectScreenState extends State<UserSetSelectScreenWidget> {
  List<int> _selectedSetIds = [];

  Future<List<int>> _fetchSelectedSets() async {
    final response = await dataService.getSets(SetFiltersDto(
      isCreatedByUser: true,
      terms: [widget.term],
    ));

    final result = response.map((e) => e.id).toList();

    _selectedSetIds = result;

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      actions: [
        AppBarAction(
          onPressed: () {
            dispatcher.dispatch(
              NavigateToAction.push(Routes.userSet, arguments: {'id': null}),
            );
          },
          icon: Icon(
            Icons.add_circle,
            color: VockifyColors.white,
          ),
        ),
      ],
      route: Routes.userSetSelect,
      body: FutureBuilder<List<int>>(
        future: _fetchSelectedSets(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return UserSetSelectListWidget(
              selectedSetIds: _selectedSetIds,
              onSelect: _onSelect,
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _onSelect(int id) {
    if (_selectedSetIds.contains(id)) {
      dispatcher.dispatch(NavigateToAction.pop());
      return;
    }

    setState(() {
      _selectedSetIds = [..._selectedSetIds, id];
    });

    dispatcher.dispatch(NavigateToAction.pop());
    dispatcher.dispatch(
      RequestAddUserTermAction(
        term: TermDto(
          id: 0,
          name: widget.term,
          definition: widget.definition,
          setId: id,
        ),
      ),
    );

    amplitude.logEvent('start_screen_term_added', eventProperties: {
      'term': widget.term,
      'definition': widget.definition,
    });
  }
}
