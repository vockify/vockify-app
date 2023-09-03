import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';
import 'package:vockify/src/theme/vockify_colors.dart';

class UserTermItemWidget extends StatelessWidget {
  final int id;
  final SlidableActionCallback onDelete;
  final SlidableActionCallback onEdit;
  final VoidCallback onTap;

  const UserTermItemWidget({
    Key? key,
    required this.id,
    required this.onDelete,
    required this.onEdit,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TermState?>(
      distinct: true,
      converter: (store) => getTermById(store.state, id),
      builder: (context, term) {
        return Slidable(
          key: term != null ? Key(term.id.toString()) : null,
          child: ListTile(
            onTap: onTap,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    term?.name ?? '',
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: Text(
                    term?.definition ?? '',
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            extentRatio: 0.25,
            children: [
              SlidableAction(
                label: 'ИЗМЕНИТЬ',
                backgroundColor: VockifyColors.fulvous,
                foregroundColor: VockifyColors.white,
                icon: Icons.edit,
                onPressed: onEdit,
              ),
              SlidableAction(
                label: 'УДАЛИТЬ',
                backgroundColor: VockifyColors.flame,
                foregroundColor: VockifyColors.white,
                icon: Icons.delete,
                onPressed: onDelete,
              ),
            ],
          ),
        );
      },
    );
  }
}
