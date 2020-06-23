import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/sets/request_public_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/set_public_sets_loader_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/common/empty.dart';
import 'package:vockify/src/widgets/pages/search/search_item.dart';
import 'package:vockify/src/widgets/pages/search/search_view_model.dart';

class SearchWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<SearchWidget> {
  Completer _completer;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StoreConnector<AppState, SearchViewModel>(
        distinct: true,
        converter: (store) => SearchViewModel.fromStore(store),
        onDidChange: (viewModel) {
          if (_completer != null && !_completer.isCompleted && viewModel.loader == LoaderState.isLoaded) {
            _completer.complete();
          }
        },
        builder: (context, viewModel) {
          if (viewModel.sets.isEmpty) {
            return EmptyWidget(
              text: 'Пусто',
            );
          }

          return RefreshIndicator(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: viewModel.sets.length,
              itemBuilder: (BuildContext context, int index) {
                final set = viewModel.sets[index];

                return SearchItemWidget(
                  set: set,
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.publicTerms, arguments: {'id': set.id});
                  },
                );
              },
            ),
            onRefresh: () async {
              dispatcher.dispatch(SetPublicSetsLoaderAction(LoaderState.refresh));
              dispatcher.dispatch(RequestPublicSetsAction());

              _completer = Completer();
              return await _completer.future;
            },
          );
        },
      ),
    );
  }
}
