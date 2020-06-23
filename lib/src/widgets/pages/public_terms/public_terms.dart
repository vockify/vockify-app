import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/terms/request_user_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/set_public_terms_loader_action.dart';
import 'package:vockify/src/redux/actions/terms/set_user_terms_loader_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/widgets/pages/public_terms/public_terms_item.dart';
import 'package:vockify/src/widgets/pages/public_terms/public_terms_view_model.dart';

class PublicTermsWidget extends StatefulWidget {
  final int setId;

  PublicTermsWidget(this.setId);

  @override
  State<StatefulWidget> createState() => _PublicTermsState();
}

class _PublicTermsState extends State<PublicTermsWidget> {
  Completer _completer;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PublicTermsViewModel>(
      distinct: true,
      converter: (store) => PublicTermsViewModel.fromStore(store, widget.setId),
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

              return PublicTermsItemWidget(
                term: term,
              );
            },
          ),
          onRefresh: () async {
            dispatcher.dispatch(SetPublicTermsLoaderAction(LoaderState.refresh));
            dispatcher.dispatch(RequestUserTermsAction(setId: widget.setId));

            _completer = Completer();
            return _completer.future;
          },
        );
      },
    );
  }
}
