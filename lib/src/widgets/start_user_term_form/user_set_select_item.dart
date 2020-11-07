import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';
import 'package:vockify/src/theme/vockify_colors.dart';

class UserSetSelectItemWidget extends StatelessWidget {
  final int id;
  final bool isSelected;
  final VoidCallback onTap;

  const UserSetSelectItemWidget({
    Key key,
    @required this.id,
    @required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SetState>(
      distinct: true,
      converter: (store) => getSetById(store.state, id),
      builder: (context, set) {
        return Card(
          margin: EdgeInsets.only(bottom: 14, top: 2),
          color: VockifyColors.ghostWhite,
          child: ListTile(
            title: Text(set.name),
            onTap: onTap,
            trailing: Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked),
          ),
        );
      },
    );
  }
}
