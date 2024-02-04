import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/pages/sets/widgets/set_list.dart';
import 'package:vockify/src/models/app_model.dart';
import 'package:vockify/src/widgets/layout.dart';

class SetsPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<AppModel, bool>(
      builder: (context, value, child) {
        return LayoutWidget(
          title: 'Словари',
          isLoading: !value,
          body: SetListWidget(),
        );
      },
      selector: (context, value) {
        return value.state.isLoaded;
      },
    );
  }
}
