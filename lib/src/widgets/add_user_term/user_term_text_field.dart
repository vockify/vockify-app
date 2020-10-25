import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserTermTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  const UserTermTextFieldWidget({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserTermTextFieldState();
}

class _UserTermTextFieldState extends State<UserTermTextFieldWidget> {
  bool _isCloseButtonVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      controller: widget.controller,
      style: TextStyle(fontSize: 24),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        suffixIcon: _isCloseButtonVisible
            ? GestureDetector(
                onTap: () {
                  widget.controller.clear();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Icon(Icons.close),
                ),
              )
            : null,
        hintText: 'Начните вводить слово',
        hintStyle: TextStyle(color: Colors.grey),
        fillColor: Colors.white,
      ),
    );
  }

  void initState() {
    super.initState();

    widget.controller.addListener(() {
      final isCloseButtonVisible = widget.controller.text.isNotEmpty;

      if (_isCloseButtonVisible != isCloseButtonVisible) {
        setState(() {
          _isCloseButtonVisible = isCloseButtonVisible;
        });
      }
    });
  }
}
