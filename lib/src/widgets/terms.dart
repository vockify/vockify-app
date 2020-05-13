import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/redux/actions/request_set_terms_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/common/layout_button_wrapper.dart';
import 'package:vockify/src/widgets/quiz/quiz.dart';
import 'package:vockify/src/widgets/sets.dart';
import 'package:vockify/src/widgets/term.dart';
import 'package:vockify/src/widgets/view_model/terms_view_model.dart';

class TermsWidget extends StatelessWidget {
  static const String route = '/terms';

  final int setId;

  TermsWidget(this.setId);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

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
                              viewModel.navigateToTerm(term.setId);
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
                    onPressed: () => store
                        .dispatch(NavigateToAction.replace(QuizWidget.route)),
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
          store.dispatch(
              NavigateToAction.replace(TermWidget.route, arguments: setId));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
