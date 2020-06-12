import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/common/empty.dart';
import 'package:vockify/src/widgets/pages/sets/sets_view_model.dart';

class SetsWidget extends StatelessWidget {
  static const String _menuItemDelete = 'delete';
  static const String _menuItemEdit = 'edit';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context, listen: false);

    return Center(
      child: StoreConnector<AppState, SetsViewModel>(
        distinct: true,
        converter: (store) => SetsViewModel.fromStore(store),
        builder: (context, viewModel) {
          if (viewModel.sets.isEmpty) {
            return EmptyWidget(
              text: 'Для начала вам необходимо создать новый словарь',
              buttonText: 'СОЗДАТЬ СЛОВАРЬ',
              onPressed: viewModel.navigateToSet,
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
                                    store.dispatch(NavigateToAction.push(Routes.set, arguments: {'id': set.id}));
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
                              store.dispatch(NavigateToAction.push(Routes.term, arguments: {
                                'setId': set.id,
                                'termId': null,
                              }));
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
    );
  }
}
