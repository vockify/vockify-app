import 'package:flutter/material.dart';
import 'package:vockify/src/theme/vockify_colors.dart';

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
        style: TextStyle(
          color: VockifyColors.prussianBlue,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        autofocus: autoFocus,
        controller: controller,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: suffix,
          label: Text(
            label.toUpperCase(),
            style: TextStyle(
              color: VockifyColors.prussianBlue,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
          fillColor: Colors.white,
          border: UnderlineInputBorder(
            borderSide: BorderSide(),
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
