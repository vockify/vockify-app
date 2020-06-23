import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vockify/src/redux/state/app_state.dart';
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

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TermsViewModel>(
      distinct: true,
      converter: (store) => TermsViewModel.fromStore(store),
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
                  viewModel.removeTerm(term.id);
                },
                slidableController: _slidableController,
              );
            },
          ),
          onRefresh: () async {
            viewModel.requestTerms(widget.setId);
          },
        );
      },
    );
  }
}
