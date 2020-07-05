import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final Widget suffix;
  final bool autoFocus;
  final bool isRequired;

  const FormTextFieldWidget({
    Key key,
    @required this.controller,
    @required this.text,
    this.suffix,
    this.autoFocus = false,
    this.isRequired = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        autofocus: autoFocus,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: suffix,
          labelText: text,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
        ),
        validator: (value) {
          if (isRequired && value.isEmpty) {
            return 'ОБЯЗАТЕЛЬНОЕ ПОЛЕ';
          }

          return null;
        },
        keyboardType: TextInputType.text,
      ),
    );
  }
}
