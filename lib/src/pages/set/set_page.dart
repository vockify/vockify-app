import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/models/app_model.dart';
import 'package:vockify/src/models/set_model/set_model.dart';
import 'package:vockify/src/models/terms_model/terms_model.dart';
import 'package:vockify/src/pages/set/widgets/set_form.dart';
import 'package:vockify/src/widgets/layout.dart';

class SetPageWidget extends StatelessWidget {
  final int? setId;

  SetPageWidget({
    this.setId,
  });

  @override
  Widget build(BuildContext context) {
    final setsState = context.read<AppModel>();
    final name = setId != null ? setsState.state.sets[setId]!.name : '';

    return Scaffold(
      body: LayoutWidget(
        title: 'Редактировать',
        body: SetFormWidget(
          name: name,
          onSave: (String name) {
            final setsState = context.read<AppModel>();

            if (setId != null) {
              final set = setsState.state.sets[setId]!;
              setsState.updateSet(set.copyWith(name: name));
            } else {
              setsState.addSet(SetModel(
                id: 0,
                name: name,
                isDefault: false,
                terms: TermsModel(
                  ids: [],
                  terms: {},
                ),
              ));
            }

            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
