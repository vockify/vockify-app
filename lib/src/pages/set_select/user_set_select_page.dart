import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/models/app_model.dart';
import 'package:vockify/src/models/term_model/term_model.dart';
import 'package:vockify/src/pages/set/set_page.dart';
import 'package:vockify/src/pages/start/widgets/user_set_select_list.dart';
import 'package:vockify/src/services/amplitude.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/app_bar_action.dart';
import 'package:vockify/src/widgets/layout.dart';

class UserSetSelectPageWidget extends StatefulWidget {
  final String term;
  final String definition;

  const UserSetSelectPageWidget({
    Key? key,
    required this.term,
    required this.definition,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserSetSelectScreenState();
}

class _UserSetSelectScreenState extends State<UserSetSelectPageWidget> {
  List<int> _selectedSetIds = [];

  Future<List<int>> _fetchSelectedSets() async {
    // final response = await dataRepository.getSets(isCreatedByUser: true);

    // final result = response.map((e) => e.id).toList();

    // _selectedSetIds = result;

    return _selectedSetIds;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      actions: [
        AppBarAction(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<SetPageWidget>(builder: (context) {
                return SetPageWidget();
              }),
            );
          },
          icon: Icon(
            Icons.add_circle,
            color: VockifyColors.white,
          ),
        ),
      ],
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
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      _selectedSetIds = [..._selectedSetIds, id];
    });

    final appModel = context.read<AppModel>();
    appModel.addTerm(
      id,
      TermModel(
        id: 0,
        setId: id,
        name: widget.term,
        definition: widget.definition,
      ),
    );

    amplitude.logEvent('start_screen_term_added', eventProperties: {
      'term': widget.term,
      'definition': widget.definition,
    });

    Navigator.of(context).pop();
  }
}
