import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state.dart';
import 'package:vockify/src/vockify_colors.dart';
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
        return ListView.builder(
          itemCount: viewModel.terms.length * 2,
          itemBuilder: (BuildContext context, int index) {
            if (index.isOdd) {
              return Divider(
                height: 0,
                thickness: 1,
              );
            }

            final term = viewModel.terms[(index / 2).round()];
            return _buildTerm(term: term, viewModel: viewModel);
          },
        );
      },
    );
  }

  Widget _buildTerm({
    @required TermState term,
    @required TermsViewModel viewModel,
  }) {
    return Slidable(
      key: Key(term.id.toString()),
      controller: _slidableController,
      actionPane: SlidableDrawerActionPane(),
      child: ListTile(
        onTap: () => viewModel.navigateToTerm(term.setId, term.id),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text('${term.name}'),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  '${term.definition}',
                ),
              ),
            ),
          ],
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'ИЗМЕНИТЬ',
          color: VockifyColors.fulvous,
          foregroundColor: VockifyColors.white,
          icon: Icons.edit,
          onTap: () => viewModel.navigateToTerm(term.setId, term.id),
        ),
        IconSlideAction(
          caption: 'УДАЛИТЬ',
          color: VockifyColors.flame,
          foregroundColor: VockifyColors.white,
          icon: Icons.delete,
          onTap: () => viewModel.removeTerm(term.setId, term.id),
        )
      ],
    );
  }
}
