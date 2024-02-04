import 'package:flutter/material.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/primary_text_form_field.dart';

class SetFormWidget extends StatefulWidget {
  final String name;
  final void Function(String name) onSave;

  const SetFormWidget({
    Key? key,
    required this.name,
    required this.onSave,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SetFormWidget();
}

class _SetFormWidget extends State<SetFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    PrimaryTextFormFieldWidget(
                      controller: _nameController,
                      label: 'Словарь',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.bottomCenter,
          child: _buildSaveButton(),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: RawMaterialButton(
            padding: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            fillColor: VockifyColors.fulvous,
            onPressed: () {
              FocusScope.of(context).unfocus();
              widget.onSave(_nameController.text);
            },
            child: Text(
              'СОХРАНИТь',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: VockifyColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  void initState() {
    super.initState();
    _nameController.text = widget.name;
  }
}
