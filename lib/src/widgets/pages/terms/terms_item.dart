import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';
import 'package:vockify/src/vockify_colors.dart';

class TermsItemWidget extends StatelessWidget {
  final TermState term;
  final SlidableController slidableController;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onTap;

  const TermsItemWidget({
    Key key,
    @required this.term,
    @required this.slidableController,
    @required this.onDelete,
    @required this.onEdit,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(term.id.toString()),
      controller: slidableController,
      actionPane: SlidableDrawerActionPane(),
      child: ListTile(
        onTap: onTap,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                '${term.name}',
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              child: Text(
                '${term.definition}',
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'ИЗМЕНИТЬ',
          color: VockifyColors.fulvous,
          foregroundColor: VockifyColors.white,
          icon: Icons.edit,
          onTap: onEdit,
        ),
        IconSlideAction(
          caption: 'УДАЛИТЬ',
          color: VockifyColors.flame,
          foregroundColor: VockifyColors.white,
          icon: Icons.delete,
          onTap: onDelete,
        )
      ],
    );
  }
}
