import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/helpers/plural.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/public_set_item/public_set_item_model.dart';

class PublicSetItemWidget extends StatelessWidget {
  final int id;
  final VoidCallback onTap;

  const PublicSetItemWidget({
    Key key,
    @required this.id,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PublicSetItemModel>(
      distinct: true,
      converter: (store) => PublicSetItemModel.fromStore(store, id),
      builder: (context, model) {
        return Card(
          margin: EdgeInsets.only(top: 16),
          color: VockifyColors.ghostWhite,
          child: ListTile(
            title: Text(model.set.name),
            subtitle: Text('${model.set.terms.count} ${plural(model.set.terms.count, ['слово', 'слова', 'слов'])}'),
            trailing: model.isAdded ? Icon(Icons.check) : null,
            onTap: onTap,
          ),
        );
      },
    );
  }
}
