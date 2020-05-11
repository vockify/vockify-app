import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/request_sets_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/view_model/add_set_modal_view_model.dart';
import 'package:vockify/src/widgets/view_model/sets_view_model.dart';

class SetsWidget extends StatelessWidget {
  static const String route = '/sets';

  final setNameController = TextEditingController();

  Future<void> _openAddSetModal(BuildContext context) async {
    await showDialog(
        context: context,
        child: StoreConnector<AppState, AddSetModalViewModel>(converter: (store) {
          return AddSetModalViewModel.fromStore(store);
        }, builder: (context, viewModel) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: setNameController,
                    autofocus: true,
                    decoration: InputDecoration(labelText: 'Set name', hintText: 'eg. Common words'),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  viewModel.close();
                },
              ),
              FlatButton(
                child: const Text('ADD'),
                onPressed: () {
                  viewModel.requestAddSet(setNameController.text);
                  viewModel.close();

                  setNameController.clear();
                },
              ),
            ],
          );
        }));
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _openAddSetModal(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    setNameController.dispose();
  }
}
