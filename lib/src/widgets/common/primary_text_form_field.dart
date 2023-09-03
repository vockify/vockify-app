import 'package:flutter/material.dart';

class PrimaryTextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Widget? suffix;
  final bool autoFocus;
  final bool isRequired;

  const PrimaryTextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.label,
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
          labelText: label,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
          ),
        ),
        validator: (value) {
          if (isRequired && (value?.isEmpty ?? false)) {
            return 'ОБЯЗАТЕЛЬНОЕ ПОЛЕ';
          }

          return null;
        },
        keyboardType: TextInputType.text,
      ),
    );
  }
}
