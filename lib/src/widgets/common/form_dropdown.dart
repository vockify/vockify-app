import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vockify/src/vockify_colors.dart';

class FormDropdownWidget extends StatelessWidget {
  final int selectedId;
  final Iterable<FormDropdownItem> items;
  final Function(int id) onChanged;

  const FormDropdownWidget({
    Key key,
    @required this.selectedId,
    @required this.items,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: VockifyColors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        border: Border.fromBorderSide(
          BorderSide(color: Colors.grey),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: DropdownButton<int>(
          value: selectedId,
          icon: Icon(Icons.arrow_drop_down),
          isExpanded: true,
          underline: Container(height: 0),
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem<int>(
              value: item.id,
              child: Text(item.text),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class FormDropdownItem {
  final int id;
  final String text;

  FormDropdownItem(this.id, this.text);
}
