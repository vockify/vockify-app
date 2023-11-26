import 'package:flutter/material.dart';
import 'package:vockify/src/theme/vockify_colors.dart';

class DefinitionChipsWidget extends StatelessWidget {
  final List<String> definitions;
  final List<String> selectedDefinitions;
  final void Function(List<String>) onChange;

  const DefinitionChipsWidget({
    Key? key,
    required this.definitions,
    required this.selectedDefinitions,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(0),
          child: Wrap(
            spacing: 8,
            children: definitions.map((definition) {
              return ChoiceChip(
                backgroundColor: VockifyColors.white,
                selectedColor: VockifyColors.lightSteelBlue,
                label: Text(
                  definition,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        color: VockifyColors.prussianBlue,
                      ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
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
