import 'package:flutter/material.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/pages/share/share_form.dart';

class SharePageWidget extends StatefulWidget {
  final String term;

  SharePageWidget(this.term);

  @override
  State<StatefulWidget> createState() => _ShareState(term);
}

class _ShareState extends State<SharePageWidget> {
  final String term;

  _ShareState(this.term);

  @override
  Widget build(BuildContext context) {
    return AppLayoutWidget(
      route: Routes.share,
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
