import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vockify/src/redux/actions/request_set_terms_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state.dart';
import 'package:vockify/src/router/router.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/common/app_button_bar.dart';
import 'package:vockify/src/widgets/view_model/terms_view_model.dart';

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
    final setId = widget.setId;
    final store = StoreProvider.of<AppState>(context);
    final set = store.state.sets.firstWhere((set) => set.id == setId, orElse: () => null);
    final setName = set?.name ?? 'Terms';

    return AppLayoutWidget(
      redirectBackRoute: Routes.sets,
      title: setName,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: null,
        ),
      ],
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
            if (viewModel.isLoading) {
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.orange),
                strokeWidth: 3.0,
              );
            }

            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
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
                  ),
                ),
                _buildButtonBar(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildButtonBar(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return AppButtonBarWidget(
      children: [
        RaisedButton(
          shape: Border(),
          color: VockifyColors.prussianBlue,
          onPressed: () => store.dispatch(NavigateToAction.push(Routes.quiz)),
          child: Text(
            'START QUIZ',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: VockifyColors.ghostWhite,
                  fontSize: 16,
                ),
          ),
        ),
        RaisedButton(
          shape: Border(),
          color: VockifyColors.fulvous,
          onPressed: () {
            final url = Router.routeToPath(Routes.term, {
              "setId": widget.setId.toString(),
              "termId": "new",
            });

            store.dispatch(
              NavigateToAction.push(url),
            );
          },
          child: Text(
            'ADD TERM',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: VockifyColors.white,
                  fontSize: 16,
                ),
          ),
        )
      ],
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
        onTap: () => viewModel.navigateToTerm(term.setId.toString(), term.id.toString()),
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
          caption: 'EDIT',
          color: VockifyColors.fulvous,
          foregroundColor: VockifyColors.white,
          icon: Icons.edit,
          onTap: () => viewModel.navigateToTerm(term.setId.toString(), term.id.toString()),
        ),
        IconSlideAction(
          caption: 'DELETE',
          color: VockifyColors.flame,
          foregroundColor: VockifyColors.white,
          icon: Icons.delete,
          onTap: () => viewModel.removeTerm(term.id),
        )
      ],
    );
  }
}
