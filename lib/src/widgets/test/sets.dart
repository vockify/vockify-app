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
      title: 'VOCKIFY',
      actions: <Widget>[
        RawMaterialButton(
          constraints: BoxConstraints(
            minWidth: 42,
            minHeight: 42,
          ),
          onPressed: () {},
          child: Icon(
            Icons.add,
            color: VockifyColors.white,
          ),
          padding: EdgeInsets.all(0),
          shape: CircleBorder(),
        ),
      ],
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
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              itemCount: viewModel.sets.length,
              itemBuilder: (BuildContext context, int index) {
                final set = viewModel.sets[index];

                return Card(
                  margin: EdgeInsets.only(top: 16),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          viewModel.navigateToTerms(set.id);
                        },
                        child: SizedBox(
                          height: 80,
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
                                        style: TextStyle(color: VockifyColors.flame),
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
                            FlatButton(onPressed: () => null, child: Text('START QUIZ'), textColor: VockifyColors.prussianBlue,),
                            FlatButton(onPressed: () => null, child: Text('ADD TERM'), textColor: VockifyColors.fulvous,),
//                            RawMaterialButton(
//                              constraints: BoxConstraints(
//                                minWidth: 32,
//                                minHeight: 32,
//                              ),
//                              onPressed: () {
//                                viewModel.navigateToQuiz(set.id);
//                              },
//                              child: Icon(
//                                Icons.play_arrow,
//                                color: VockifyColors.prussianBlue,
//                                size: 32,
//                              ),
//                              padding: EdgeInsets.all(0),
//                              shape: CircleBorder(),
//                            ),
//                            RawMaterialButton(
//                              constraints: BoxConstraints(
//                                minWidth: 32,
//                                minHeight: 32,
//                              ),
//                              onPressed: () {
//                                viewModel.navigateToTerm(set.id);
//                              },
//                              child: Icon(
//                                Icons.add,
//                                color: VockifyColors.carrotOrange,
//                                size: 32,
//                              ),
//                              padding: EdgeInsets.all(0),
//                              shape: CircleBorder(),
//                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
