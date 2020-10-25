import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/add_user_term/user_set_select_item.dart';
import 'package:vockify/src/widgets/common/empty.dart';

class UserSetSelectListWidget extends StatelessWidget {
  final int selectedSetId;
  final Function(int) onSelect;

  const UserSetSelectListWidget({
    Key key,
    @required this.onSelect,
    this.selectedSetId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(24),
            child: Text('Выберите словарь', style: Theme.of(context).textTheme.bodyText2.copyWith(
              fontSize: 18,
            ),),
          ),
          Expanded(
            child: StoreConnector<AppState, List<int>>(
              distinct: true,
              converter: (store) => getUserSetIds(store.state),
              builder: (context, ids) {
                if (ids.isEmpty) {
                  return EmptyWidget(
                    text: 'Для начала вам необходимо создать новый словарь',
                    buttonText: 'СОЗДАТЬ СЛОВАРЬ',
                    onPressed: () {
                      // todo: fix navigation
                      Navigator.of(context).pushNamed(Routes.userSet, arguments: {'id': null});
                    },
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: ids.length,
                  itemBuilder: (BuildContext context, int index) {
                    final id = ids[index];

                    return UserSetSelectItemWidget(
                      id: id,
                      isSelected: selectedSetId == id,
                      onTap: () {
                        onSelect(id);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
