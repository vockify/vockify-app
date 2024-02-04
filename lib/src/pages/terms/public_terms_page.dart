import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/pages/terms/user_terms_page.dart';
import 'package:vockify/src/pages/terms/widgets/public_term_list.dart';
import 'package:vockify/src/models/app_model.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/layout.dart';

class PublicTermsPageWidget extends StatelessWidget {
  final int setId;

  PublicTermsPageWidget({required this.setId});

  @override
  Widget build(BuildContext context) {
    final setsState = Provider.of<AppModel>(context, listen: false);
    final set = setsState.state.sets[setId]!;

    return LayoutWidget(
      title: set.name,
      body: Center(
        child: Stack(
          children: <Widget>[
            PublicTermListWidget(
              setId: set.id,
            ),
            if (!setsState.isSetCopied(setId))
              Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RawMaterialButton(
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        fillColor: VockifyColors.prussianBlue,
                        onPressed: () async {
                          final id = await setsState.copySet(setId);
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute<UserTermsPageWidget>(
                              builder: (context) {
                                return UserTermsPageWidget(setId: id);
                              },
                            ),
                          );
                        },
                        child: Text(
                          'СОХРАНИТЬ В МОИ СЛОВАРИ',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: VockifyColors.ghostWhite,
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
