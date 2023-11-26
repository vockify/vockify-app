import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/helpers/plural.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';
import 'package:vockify/src/theme/vockify_colors.dart';

class UserSetItemWidget extends StatelessWidget {
  static const String _menuItemDelete = 'delete';
  static const String _menuItemEdit = 'edit';

  final int id;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onTap;

  const UserSetItemWidget({
    Key? key,
    required this.id,
    required this.onDelete,
    required this.onEdit,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SetState?>(
      distinct: true,
      converter: (store) => getSetById(store.state, id),
      builder: (context, set) {
        return Card(
          margin: EdgeInsets.only(top: 24),
          color: VockifyColors.white,
          elevation: 2,
          shadowColor: VockifyColors.lightSteelBlue,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            minVerticalPadding: 20,
            title: Text(
              set?.name ?? '',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            subtitle: Text(
              '${set?.terms.count ?? 0} ${plural(set?.terms.count ?? 0, ['термин', 'термина', 'терминов'])}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: VockifyColors.black,
              ),
              textAlign: TextAlign.end,
            ),
            onTap: onTap,
          ),
        );
      },
    );
  }
}
