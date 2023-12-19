import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/models/app_model.dart';
import 'package:vockify/src/navigation/navigation_holder.dart';
import 'package:vockify/src/pages/flashcards/flashcards_page.dart';
import 'package:vockify/src/pages/quiz/quiz_page.dart';
import 'package:vockify/src/pages/terms/widgets/user_term_item.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/empty.dart';

class UserTermListWidget extends StatelessWidget {
  final int setId;

  UserTermListWidget({
    required this.setId,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<AppModel, List<int>?>(
      builder: (context, ids, child) {
        if (ids == null || ids.isEmpty) {
          return EmptyWidget(
            text: 'В словаре пока нет слов',
            icon: Icons.search,
          );
        }

        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: RawMaterialButton(
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        fillColor: VockifyColors.prussianBlue,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<QuizPageWidget>(
                              builder: (context) {
                                return QuizPageWidget(setId: setId);
                              },
                            ),
                          );
                        },
                        child: Text(
                          'УЧИТЬ',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: VockifyColors.ghostWhite,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: RawMaterialButton(
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        fillColor: VockifyColors.persianGreen,
                        onPressed: () {
                          Navigator.of(
                                  NavigatorHolder.navigatorKey.currentContext!)
                              .push(
                            MaterialPageRoute<FlashcardsPageWidget>(
                              builder: (context) {
                                return FlashcardsPageWidget(
                                  setId: setId,
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          'ФЛЕШКАРТЫ',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: VockifyColors.ghostWhite,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                child: Text(
                  'Термины',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                  // textAlign: TextAlign.left,
                ),
              ),
              ListView.builder(
                padding:
                    EdgeInsets.only(bottom: 0, left: 16, right: 16, top: 24),
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: ids.length,
                itemBuilder: (BuildContext context, int index) {
                  final id = ids[index];

                  return UserTermItemWidget(
                    setId: setId,
                    termId: id,
                  );
                },
              ),
            ],
          ),
        );
      },
      selector: (context, value) => value.state.sets[setId]?.terms.ids,
    );
  }
}
