import 'package:flutter/material.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/pages/term/term.dart';

class TermPageWidget extends StatelessWidget {
  final int setId;
  final int termId;

  TermPageWidget(this.setId, this.termId);

  @override
  Widget build(BuildContext context) {
    return AppLayoutWidget(
      route: Routes.term,
      title: termId == null ? 'ДОБАВИТЬ СЛОВО' : 'ИЗМЕНИТЬ СЛОВО',
      body: TermWidget(setId, termId),
    );
  }
}
