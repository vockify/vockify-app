import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/models/app_model.dart';
import 'package:vockify/src/models/term_model/term_model.dart';
import 'package:vockify/src/pages/start/widgets/history_term_item.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/empty.dart';

class HistoryTermListWidget extends StatelessWidget {
  final void Function(String) onTap;

  const HistoryTermListWidget({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final terms = context.select<AppModel, List<TermModel>>((value) => value.lastAddedTerms);

    if (terms.isEmpty) {
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
          itemCount: terms.length + 1,
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

            final term = terms[index - 1];

            return Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: HistoryTermItemWidget(
                key: ValueKey(term.id),
                term: term,
                onTap: (text) {
                  onTap(text);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
