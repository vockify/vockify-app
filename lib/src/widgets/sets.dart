import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/add_set_action.dart';
import 'package:vockify/src/redux/actions/load_sets_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/widgets/view_model/sets_view_model.dart';

class SetsWidget extends StatelessWidget {
  final setNameController = TextEditingController();

  Future<void> _openAddModal(BuildContext context) async {
    await showDialog(
        context: context,
        child: StoreConnector<AppState, void Function(String)>(
            converter: (store) {
              return (String name) => store.dispatch(new AddSetAction(name));
            },
            builder: (context, addSet) {
              return new AlertDialog(
                contentPadding: const EdgeInsets.all(16.0),
                content: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new TextField(
                        controller: setNameController,
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Set name',
                            hintText: 'eg. Common words'
                        ),
                      ),
                    )
                  ],
                ),
                actions: <Widget>[
                  new FlatButton(
                      child: const Text('CANCEL'),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  new FlatButton(
                      child: const Text('ADD'),
                      onPressed: () {
                        addSet(setNameController.text);
                        Navigator.pop(context);
                        setNameController.clear();
                      })
                ],
              );
            }
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sets'),
      ),
      body: Center(
        child: StoreConnector<AppState, SetsViewModel>(
          onInit: (store) {
            store.dispatch(LoadSetsAction());
          },
          converter: (store) {
            return SetsViewModel.fromStore(store);
          },
          builder: (context, vm) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: vm.sets.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                    key: UniqueKey(),
                    child: Container(
                      height: 50,
                      color: Colors.amber,
                      child: Center(child: Text(vm.sets[index].name)),
                    ),
                    background: Container(color: Colors.red),
                    onDismissed: (direction) {
                      vm.removeSet(vm.sets[index].id);
                    }
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _openAddModal(context);
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
