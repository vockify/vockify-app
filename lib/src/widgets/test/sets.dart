import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/request_sets_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/view_model/sets_view_model.dart';

class SetsWidget extends StatelessWidget {
  static const String route = '/sets';

  @override
  Widget build(BuildContext context) {
    return AppLayoutWidget(
      title: 'Sets',
      body: Center(
        child: StoreConnector<AppState, SetsViewModel>(
          onInit: (store) {
            store.dispatch(RequestSetsAction());
          },
          distinct: true,
          converter: (store) {
            return SetsViewModel.fromStore(store);
          },
          builder: (context, viewModel) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: viewModel.sets.length,
              itemBuilder: (BuildContext context, int index) {
                final set = viewModel.sets[index];

                return Card(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          viewModel.navigateToTerms(set.id);
                        },
                        child: SizedBox(
                          height: 120,
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Container(
                                  color: VockifyColors.ghostWhite,
                                ),
                              ),
                              Positioned(
                                bottom: 16,
                                left: 16,
                                right: 16,
                                child: Text(
                                  set.name,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: PopupMenuButton(
                                  padding: EdgeInsets.all(0),
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    )
                                  ],
                                  onSelected: (item) {
                                    if (item == 'delete') {
                                      viewModel.removeSet(set.id);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.more_horiz,
                                    color: VockifyColors.prussianBlue,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      ButtonBarTheme(
                        data: ButtonBarTheme.of(context),
                        child: ButtonBar(
                          alignment: MainAxisAlignment.end,
                          buttonAlignedDropdown: true,
                          overflowDirection: VerticalDirection.up,
                          children: <Widget>[
                            FlatButton(
                              color: Colors.white,
                              child: Text('Learn'),
                              onPressed: () => viewModel.navigateToQuiz(set.id),
                              textColor: VockifyColors.prussianBlue,
                            ),
                            RawMaterialButton(
                              onPressed: () {
                                viewModel.navigateToTerm(set.id);
                              },
                              fillColor: VockifyColors.prussianBlue,
                              child: Icon(
                                Icons.add,
                                color: VockifyColors.ghostWhite,
                              ),
                              padding: EdgeInsets.all(0),
                              shape: CircleBorder(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );

                return Dismissible(
                  key: Key(set.id.toString()),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        viewModel.navigateToTerms(set.id);
                      },
                      title: Text(set.name),
                    ),
                  ),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    viewModel.removeSet(set.id);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
