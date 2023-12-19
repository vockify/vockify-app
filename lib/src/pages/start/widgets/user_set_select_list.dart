import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/models/app_model.dart';
import 'package:vockify/src/pages/set/set_page.dart';
import 'package:vockify/src/pages/start/widgets/user_set_select_item.dart';
import 'package:vockify/src/widgets/common/empty.dart';

class UserSetSelectListWidget extends StatelessWidget {
  final List<int> selectedSetIds;
  final void Function(int) onSelect;

  const UserSetSelectListWidget({
    Key? key,
    required this.onSelect,
    required this.selectedSetIds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ids = context.select<AppModel, List<int>>((value) => value.state.ids
        .where((id) => !value.state.sets[id]!.isDefault)
        .toList());

    return Center(
      child: Column(
        children: [
          if (ids.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Выберите словарь',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 18,
                    ),
              ),
            ),
          Expanded(
            child: ids.isEmpty
                ? EmptyWidget(
                    text: 'Для начала вам необходимо создать новый словарь',
                    buttonText: 'СОЗДАТЬ СЛОВАРЬ',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<SetPageWidget>(
                          builder: (context) {
                            return SetPageWidget();
                          },
                        ),
                      );
                    })
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: ids.length,
                    itemBuilder: (BuildContext context, int index) {
                      final id = ids[index];

                      return UserSetSelectItemWidget(
                        id: id,
                        isSelected: selectedSetIds.contains(id),
                        onTap: () {
                          onSelect(id);
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
