import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/navigation/navigate_to_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/empty.dart';
import 'package:vockify/src/widgets/user_term_item/user_term_item.dart';

class UserTermListWidget extends StatefulWidget {
  final int setId;

  UserTermListWidget(this.setId);

  @override
  State<StatefulWidget> createState() => _UserTermListState();
}

class _UserTermListState extends State<UserTermListWidget> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<int>>(
      distinct: true,
      converter: (store) => getTermIds(store.state),
      builder: (context, ids) {
        if (ids.isEmpty) {
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
                          dispatcher.dispatch(NavigateToAction.push(Routes.quiz, arguments: {'setId': widget.setId}));
                        },
                        child: Text(
                          'УЧИТЬ',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                          dispatcher
                              .dispatch(NavigateToAction.push(Routes.flashcards, arguments: {'setId': widget.setId}));
                        },
                        child: Text(
                          'ФЛЕШКАРТЫ',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                padding: EdgeInsets.only(bottom: 0, left: 16, right: 16, top: 24),
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: ids.length,
                itemBuilder: (BuildContext context, int index) {
                  final id = ids[index];

                  return UserTermItemWidget(
                    key: ValueKey(id),
                    id: id,
                    setId: widget.setId,
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.userTerm, arguments: {
                        "setId": widget.setId,
                        "termId": id,
                      });
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
