import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/common/empty.dart';
import 'package:vockify/src/widgets/pages/sets/sets_item.dart';
import 'package:vockify/src/widgets/pages/sets/sets_view_model.dart';

class SetsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StoreConnector<AppState, SetsViewModel>(
        distinct: true,
        converter: (store) => SetsViewModel.fromStore(store),
        builder: (context, viewModel) {
          if (viewModel.sets.isEmpty) {
            return EmptyWidget(
              text: 'Для начала вам необходимо создать новый словарь',
              buttonText: 'СОЗДАТЬ СЛОВАРЬ',
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.set, arguments: {'id': null});
              },
            );
          }

          return RefreshIndicator(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: viewModel.sets.length,
              itemBuilder: (BuildContext context, int index) {
                final set = viewModel.sets[index];

                return SetsItem(
                  set: set,
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.terms, arguments: {'id': set.id});
                  },
                  onDelete: () {
                    viewModel.removeSet(set.id);
                  },
                  onEdit: () {
                    Navigator.of(context).pushNamed(Routes.set, arguments: {'id': set.id});
                  },
                );
              },
            ),
            onRefresh: () async {
              viewModel.requestSets();
            },
          );
        },
      ),
    );
  }
}
