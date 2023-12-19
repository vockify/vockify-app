import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/helpers/plural.dart';
import 'package:vockify/src/models/set_model/set_model.dart';
import 'package:vockify/src/pages/terms/public_terms_page.dart';
import 'package:vockify/src/pages/terms/user_terms_page.dart';
import 'package:vockify/src/models/app_model.dart';
import 'package:vockify/src/theme/vockify_colors.dart';

class SetItemWidget extends StatelessWidget {
  final int id;

  const SetItemWidget({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<AppModel, SetModel>(
      builder: (context, set, child) {
        return Card(
          margin: EdgeInsets.only(top: 24),
          color: VockifyColors.white,
          elevation: 2,
          shadowColor: VockifyColors.lightSteelBlue,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            minVerticalPadding: 20,
            title: Text(
              set.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            subtitle: Text(
              '${set.terms.ids.length} ${plural(set.terms.ids.length, [
                    'термин',
                    'термина',
                    'терминов'
                  ])}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: VockifyColors.black,
              ),
              textAlign: TextAlign.end,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<UserTermsPageWidget>(
                  builder: (context) {
                    return set.isDefault
                        ? PublicTermsPageWidget(setId: set.id)
                        : UserTermsPageWidget(setId: set.id);
                  },
                ),
              );
            },
          ),
        );
      },
      selector: (context, value) => value.state.sets[id]!,
    );
  }
}
