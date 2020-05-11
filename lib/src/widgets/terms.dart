import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/request_set_terms_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/sets.dart';
import 'package:vockify/src/widgets/view_model/terms_view_model.dart';

class TermsWidget extends StatelessWidget {
  static const String route = '/terms';

  final int setId;

  TermsWidget(this.setId);

  @override
  Widget build(BuildContext context) {
    return AppLayoutWidget(
      title: 'Terms',
      redirectBackRoute: SetsWidget.route,
      body: Center(
        child: StoreConnector<AppState, TermsViewModel>(
          onInit: (store) {
            store.dispatch(RequestSetTermsAction(setId));
          },
          distinct: true,
          converter: (store) {
            return TermsViewModel.fromStore(store);
          },
          builder: (context, viewModel) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: viewModel.terms.length,
              itemBuilder: (BuildContext context, int index) {
                final set = viewModel.terms[index];

                return Card(
                  child: ListTile(
                    title: Text(set.name),
                  ),
                );
              },
            );
          },
        ),
      )
    );
  }
}
