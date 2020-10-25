import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserTermTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const UserTermTextFieldWidget({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      controller: controller,
      style: TextStyle(fontSize: 24),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(24),
        suffixIcon: GestureDetector(
          onTap: () {
            controller.clear();
          },
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Icon(Icons.close),
          ),
        ),
        hintText: 'Начните вводить слово',
        fillColor: Colors.white,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
    );
  }
}
