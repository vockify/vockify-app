import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/empty.dart';
import 'package:vockify/src/widgets/start_user_term_form/history_term_item.dart';

class HistoryTermListWidget extends StatelessWidget {
  final void Function(String) onTap;

  const HistoryTermListWidget({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<int>>(
      distinct: true,
      converter: (store) => getLastAddedTermIds(store.state),
      builder: (context, ids) {
        if (ids.isEmpty) {
          return Expanded(
              child: EmptyWidget(
            text: "Начните вводить слово и добавьте его в словарь",
            icon: Icons.history,
          ));
        }

        return Expanded(
          child: Container(
            color: VockifyColors.ghostWhite,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 16, bottom: 32),
              itemCount: ids.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Последние добавленные слова',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
          ),
        );
      },
    );
  }
}
