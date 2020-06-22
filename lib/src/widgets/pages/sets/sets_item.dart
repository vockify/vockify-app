import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vockify/src/helpers/plural.dart';
import 'package:vockify/src/redux/state/set_state.dart';
import 'package:vockify/src/vockify_colors.dart';

class SetsItem extends StatelessWidget {
  static const String _menuItemDelete = 'delete';
  static const String _menuItemEdit = 'edit';

  final SetState set;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onTap;

  const SetsItem({
    Key key,
    @required this.set,
    @required this.onDelete,
    @required this.onEdit,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 16),
      color: VockifyColors.ghostWhite,
      child: ListTile(
        title: Text(set.name),
        subtitle: Text('${set.termsCount} ${plural(set.termsCount, ['слово', 'слова', 'слов'])}'),
        trailing: PopupMenuButton(
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
          onSelected: _onSelected,
          icon: Icon(
            Icons.more_horiz,
            color: VockifyColors.prussianBlue,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  void _onSelected(String item) {
    if (item == _menuItemDelete) {
      onDelete();
    } else if (item == _menuItemEdit) {
      onEdit();
    }
  }
}
