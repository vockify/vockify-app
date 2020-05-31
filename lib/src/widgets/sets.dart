import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/redux/actions/request_sets_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/router.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/view_model/sets_view_model.dart';

class SetsWidget extends StatelessWidget {
  static const String _menuItemDelete = 'delete';
  static const String _menuItemEdit = 'edit';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context, listen: false);

    return AppLayoutWidget(
      title: 'VOCKIFY',
      actions: <Widget>[
        RawMaterialButton(
          constraints: BoxConstraints(
            minWidth: 42,
            minHeight: 42,
          ),
          onPressed: () {
            final url = Router.routeToPath(Routes.set, {'id': 'new'});
            store.dispatch(NavigateToAction.push(url));
          },
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
            if (viewModel.sets.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ДЛЯ НАЧАЛА ВАМ НУЖНО ДОБАВИТЬ НАБОР',
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    FlatButton(
                      color: VockifyColors.fulvous,
                      textColor: VockifyColors.white,
                      onPressed: viewModel.navigateToSet,
                      child: Text('ДОБАВИТЬ НАБОР'),
                    )
                  ],
                ),
              );
            }

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
                                    PopupMenuItem(
                                      value: _menuItemEdit,
                                      child: Text(
                                        'ИЗМЕНИТЬ',
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: _menuItemDelete,
                                      child: Text(
                                        'УДАЛИТЬ',
                                        style: TextStyle(color: VockifyColors.flame),
                                      ),
                                    )
                                  ],
                                  onSelected: (item) {
                                    if (item == _menuItemDelete) {
                                      viewModel.removeSet(set.id);
                                    } else if (item == _menuItemEdit) {
                                      final url = Router.routeToPath(Routes.set, {'id': set.id.toString()});
                                      store.dispatch(NavigateToAction.push(url));
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
                              onPressed: () => viewModel.navigateToQuiz(set.id),
                              child: Text('УЧИТЬ'),
                              textColor: VockifyColors.prussianBlue,
                            ),
                            FlatButton(
                              onPressed: () {
                                final url = Router.routeToPath(
                                  Routes.term,
                                  {
                                    'setId': set.id.toString(),
                                    'termId': 'new',
                                  },
                                );

                                store.dispatch(NavigateToAction.push(url));
                              },
                              child: Text('ДОБАВИТЬ СЛОВО'),
                              textColor: VockifyColors.fulvous,
                            ),
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
