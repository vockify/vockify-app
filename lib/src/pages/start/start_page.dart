import 'package:flutter/material.dart';
import 'package:vockify/src/pages/start/widgets/start_user_term_form.dart';
import 'package:vockify/src/widgets/layout.dart';

class StartPageWidget extends StatelessWidget {
  final String? term;

  const StartPageWidget({Key? key, this.term}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      body: StartUserTermFormWidget(term: term),
    );
  }
}
