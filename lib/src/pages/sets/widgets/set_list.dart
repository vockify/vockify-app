import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/pages/sets/widgets/set_item.dart';
import 'package:vockify/src/models/app_model.dart';
import 'package:vockify/src/theme/vockify_colors.dart';

class SetListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: VockifyColors.ghostWhite,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 16),
        physics: BouncingScrollPhysics(),
        child: Consumer<AppModel>(
          builder: (context, value, child) {
            final state = value.state;
            final userSetIds =
                state.ids.where((id) => !state.sets[id]!.isDefault).toList();

            final defaultSetIds = state.ids.where((id) {
              final set = state.sets[id]!;
              final isCopied = userSetIds.any(
                (userSetId) => state.sets[userSetId]!.parentId == id,
              );
              return set.isDefault && !isCopied;
            }).toList();

            return Column(
              children: <Widget>[
                ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: userSetIds.length,
                  itemBuilder: (BuildContext context, int index) {
                    final id = userSetIds[index];
                    return SetItemWidget(
                      id: id,
                    );
                  },
                ),
                if (defaultSetIds.isEmpty)
                  Container()
                else
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                          bottom: 10,
                        ),
                        child: Text(
                          'Популярные словари',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: defaultSetIds.length,
                        itemBuilder: (BuildContext context, int index) {
                          final id = defaultSetIds[index];
                          return SetItemWidget(
                            id: id,
                          );
                        },
                      ),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
