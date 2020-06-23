import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

class PublicTermsItemWidget extends StatelessWidget {
  final TermState term;

  const PublicTermsItemWidget({
    Key key,
    @required this.term,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
  }
}
