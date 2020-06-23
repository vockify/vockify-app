import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vockify/src/redux/actions/terms/request_remove_user_term_action.dart';
import 'package:vockify/src/redux/actions/terms/request_user_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/set_user_terms_loader_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/pages/terms/terms_item.dart';
import 'package:vockify/src/widgets/pages/terms/terms_view_model.dart';

class TermsWidget extends StatefulWidget {
  final int setId;

  TermsWidget(this.setId);

  @override
  State<StatefulWidget> createState() => _TermsState();
}

class _TermsState extends State<TermsWidget> {
  final _slidableController = SlidableController();

  Completer _completer;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TermsViewModel>(
      distinct: true,
      converter: (store) => TermsViewModel.fromStore(store, widget.setId),
      onDidChange: (viewModel) {
        if (_completer != null && !_completer.isCompleted && viewModel.loader == LoaderState.isLoaded) {
          _completer.complete();
        }
      },
      builder: (context, viewModel) {
        return RefreshIndicator(
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 80),
            itemCount: viewModel.terms.length * 2,
            itemBuilder: (BuildContext context, int index) {
              if (index.isOdd) {
                return Divider(
                  height: 0,
                  thickness: 1,
                );
              }

              final term = viewModel.terms[(index / 2).round()];

              return TermsItemWidget(
                term: term,
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.term, arguments: {
                    "setId": term.setId,
                    "termId": term.id,
                  });
                },
                onEdit: () {
                  Navigator.of(context).pushNamed(Routes.term, arguments: {
                    "setId": term.setId,
                    "termId": term.id,
                  });
                },
                onDelete: () {
                  dispatcher.dispatch(RequestRemoveUserTermAction(term.id, term.setId));
                },
                slidableController: _slidableController,
              );
            },
          ),
          onRefresh: () async {
            dispatcher.dispatch(SetUserTermsLoaderAction(LoaderState.refresh));
            dispatcher.dispatch(RequestUserTermsAction(setId: widget.setId));

            _completer = Completer();
            return _completer.future;
          },
        );
      },
    );
  }
}
