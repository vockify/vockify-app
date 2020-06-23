import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vockify/src/helpers/plural.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';
import 'package:vockify/src/vockify_colors.dart';

class SearchItemWidget extends StatelessWidget {
  final SetState set;
  final VoidCallback onTap;

  const SearchItemWidget({
    Key key,
    @required this.set,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 16),
      color: VockifyColors.lightSteelBlue,
      child: ListTile(
        title: Text(set.name),
        subtitle: Text('${set.termsCount} ${plural(set.termsCount, ['слово', 'слова', 'слов'])}'),
        onTap: onTap,
      ),
    );
  }
}
