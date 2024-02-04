import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/models/app_model.dart';
import 'package:vockify/src/models/set_model/set_model.dart';
import 'package:vockify/src/theme/vockify_colors.dart';

class UserSetSelectItemWidget extends StatelessWidget {
  final int id;
  final bool isSelected;
  final VoidCallback onTap;

  const UserSetSelectItemWidget({
    Key? key,
    required this.id,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final set =
        context.select<AppModel, SetModel?>((value) => value.state.sets[id]);

    return Card(
      margin: EdgeInsets.only(bottom: 14, top: 2),
      color: VockifyColors.ghostWhite,
      child: ListTile(
        title: Text(set?.name ?? ''),
        onTap: onTap,
        trailing: Icon(isSelected
            ? Icons.radio_button_checked
            : Icons.radio_button_unchecked),
      ),
    );
  }
}
