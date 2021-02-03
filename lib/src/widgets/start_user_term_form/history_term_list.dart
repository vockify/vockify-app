import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/start_user_term_form/history_term_item.dart';

class HistoryTermListWidget extends StatelessWidget {
  final Function(String) onTap;

  const HistoryTermListWidget({
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<int>>(
      distinct: true,
      converter: (store) => getLastAddedTermIds(store.state),
      builder: (context, ids) {
        if (ids.isEmpty) {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.history,
                  color: VockifyColors.black,
                  size: 64,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(48, 0, 48, 16),
                  child: Text(
                    'Начните вводить слово и добавьте его в словарь',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: VockifyColors.black,
                          fontSize: 18,
                          height: 1.3,
                        ),
                  ),
                ),
              ],
            ),
          );
        }

        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 16, bottom: 32),
            itemCount: ids.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Последние добавленные слова',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                  ),
                );
              }

              final id = ids[index - 1];

              return Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: HistoryTermItemWidget(
                  key: ValueKey(id),
                  id: id,
                  onTap: (text) {
                    onTap(text);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
