import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';
import 'package:vockify/src/theme/vockify_colors.dart';

class HistoryTermItemWidget extends StatelessWidget {
  final int id;
  final void Function(String) onTap;

  const HistoryTermItemWidget({
    Key? key,
    required this.id,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TermState?>(
      distinct: true,
      converter: (store) => getTermById(store.state, id),
      builder: (context, term) {
        return GestureDetector(
          onTap: () {
            onTap(term?.name ?? '');
          },
          child: Card(
            margin: EdgeInsets.all(0),
            color: VockifyColors.white,
            elevation: 1,
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      term?.name ?? '',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      term?.definition ?? '',
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
