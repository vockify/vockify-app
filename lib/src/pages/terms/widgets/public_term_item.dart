import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/models/term_model/term_model.dart';
import 'package:vockify/src/models/app_model.dart';

class PublicTermItemWidget extends StatelessWidget {
  final int setId;
  final int termId;

  const PublicTermItemWidget({
    Key? key,
    required this.setId,
    required this.termId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final term = context.select<AppModel, TermModel>((value) {
      return value.state.sets[setId]!.terms.terms[termId]!;
    });

    return Card(
      margin: EdgeInsets.only(bottom: 24),
      elevation: 2,
      child: ListTile(
        minVerticalPadding: 14,
        title: Text(
          term.name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            term.definition,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
