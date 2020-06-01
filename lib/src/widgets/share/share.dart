import 'package:flutter/material.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/share/share_form.dart';

class ShareWidget extends StatefulWidget {
  final String term;

  ShareWidget(this.term);

  @override
  State<StatefulWidget> createState() => _ShareState(term);
}

class _ShareState extends State<ShareWidget> {
  final String term;

  _ShareState(this.term);

  @override
  Widget build(BuildContext context) {
    return AppLayoutWidget(
      title: 'ДОБАВИТЬ СЛОВО',
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: ShareFormWidget(term),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
