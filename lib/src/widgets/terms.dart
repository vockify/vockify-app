import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/redux/actions/request_set_terms_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/route_list.dart';
import 'package:vockify/src/router/router.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/common/layout_button_wrapper.dart';
import 'package:vockify/src/widgets/view_model/terms_view_model.dart';

class TermsWidget extends StatelessWidget {
  final int setId;

  TermsWidget(this.setId);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return AppLayoutWidget(
      title: 'Terms',
      redirectBackRoute: RouteList.sets,
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
                    padding: const EdgeInsets.all(10),
                    itemCount: viewModel.terms.length,
                    itemBuilder: (BuildContext context, int index) {
                      final term = viewModel.terms[index];

                      return Dismissible(
                        key: Key(term.id.toString()),
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              viewModel.navigateToTerm(term.setId.toString(), term.id.toString());
                            },
                            title: Text('${term.name} / ${term.definition}'),
                          ),
                        ),
                        background: Container(color: Colors.red),
                        onDismissed: (direction) {
                          viewModel.removeTerm(term.id);
                        },
                      );
                    },
                  ),
                ),
                LayoutButtonWrapperWidget(
                  child: RaisedButton(
                    color: Colors.blueAccent,
                    onPressed: () => store.dispatch(NavigateToAction.push(RouteList.quiz)),
                    child: Text('Quiz'),
                  ),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          store.dispatch(NavigateToAction.push(Router.routeToPath(RouteList.term, {
            "setId": setId.toString(),
            "termId": "new",
          })));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
