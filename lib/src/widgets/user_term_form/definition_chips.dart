import 'package:flutter/material.dart';
import 'package:vockify/src/theme/vockify_colors.dart';

class DefinitionChipsWidget extends StatelessWidget {
  final List<String> definitions;
  final List<String> selectedDefinitions;
  final Function(List<String>) onChange;

  const DefinitionChipsWidget({
    Key key,
    @required this.definitions,
    @required this.selectedDefinitions,
    @required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            'Выберите значения:',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 16,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Wrap(
            spacing: 8,
            children: definitions.map((definition) {
              return ChoiceChip(
                backgroundColor: VockifyColors.white,
                selectedColor: VockifyColors.lightSteelBlue,
                label: Text(
                  definition,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontSize: 16,
                      ),
                ),
                labelStyle: TextStyle(color: VockifyColors.black),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: VockifyColors.lightSteelBlue,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
                selected: selectedDefinitions.contains(definition),
                onSelected: (bool selected) {
                  final updated = selectedDefinitions.toList();

                  if (selected) {
                    updated.add(definition);
                  } else {
                    updated.remove(definition);
                  }

                  onChange(updated);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
