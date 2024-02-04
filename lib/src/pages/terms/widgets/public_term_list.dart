import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/pages/terms/widgets/public_term_item.dart';
import 'package:vockify/src/models/app_model.dart';
import 'package:vockify/src/widgets/common/empty.dart';

class PublicTermListWidget extends StatelessWidget {
  final int setId;

  PublicTermListWidget({
    required this.setId,
  });

  @override
  Widget build(BuildContext context) {
    final setsState = Provider.of<AppModel>(context, listen: false);
    final set = setsState.state.sets[setId]!;

    if (set.terms.ids.isEmpty) {
      return EmptyWidget(
        text: 'В словаре пока нет слов',
        icon: Icons.search,
      );
    }

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
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
            itemCount: set.terms.ids.length,
            itemBuilder: (BuildContext context, int index) {
              final id = set.terms.ids[index];
              final term = set.terms.terms[id]!;

              return PublicTermItemWidget(
                key: ValueKey(term.id),
                setId: setId,
                termId: term.id,
              );
            },
          ),
        ],
      ),
    );
  }
}
