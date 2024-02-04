import 'package:flutter/material.dart';
import 'package:vockify/src/models/term_model/term_model.dart';
import 'package:vockify/src/theme/vockify_colors.dart';

class HistoryTermItemWidget extends StatelessWidget {
  final TermModel term;
  final void Function(String) onTap;

  const HistoryTermItemWidget({
    Key? key,
    required this.term,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(term.name);
      },
      child: Card(
        margin: EdgeInsets.all(0),
        color: VockifyColors.white,
        elevation: 1,
        child: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  term.name,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                      ),
                ),
              ),
              Expanded(
                child: Text(
                  term.definition,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
