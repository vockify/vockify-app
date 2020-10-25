import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/translate/translate_request_dto.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/add_user_term/user_term_text_field.dart';

class AddUserTermWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddUserTermState();
}

class _AddUserTermState extends State<AddUserTermWidget> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _term = '';
  String _transcription = '';
  List<String> _definitions = [];

  final List<String> _selectedDefinitions = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: UserTermTextFieldWidget(
                  controller: _nameController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: RichText(
                  text: TextSpan(
                    text: _term,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 20,
                        ),
                    children: [
                      TextSpan(
                        text: ' [${_transcription}]',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: 20,
                              color: VockifyColors.lightSteelBlue,
                            ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text('Выберите перевод:'),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: _buildDefinitionChips(),
              ),
              _buildAddButton(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }

  void initState() {
    super.initState();

    _nameController.addListener(() {
      if (_nameController.text.isEmpty) {
        if (_definitions.isNotEmpty || _transcription.isNotEmpty) {
          setState(() {
            _term = '';
            _transcription = '';
            _definitions = [];
          });
        }
      }

      EasyDebounce.debounce(
        'translate',
        Duration(milliseconds: 500),
        _translate,
      );
    });
  }

  Widget _buildAddButton() {
    if (_definitions.isEmpty) {
      return Container();
    }

    final definition = _selectedDefinitions.isEmpty ? _definitions.first : _selectedDefinitions.join(', ');

    return Container(
      padding: EdgeInsets.only(top: 16),
      alignment: Alignment.bottomCenter,
      child: Row(
        children: <Widget>[
          Expanded(
            child: RawMaterialButton(
              padding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
              fillColor: VockifyColors.prussianBlue,
              onPressed: () {
                dispatcher.dispatch(
                  NavigateToAction.push(Routes.userSetSelect, arguments: {
                    'term': _term,
                    'definition': definition,
                  }),
                );
              },
              child: Text(
                'Добавить в словарь',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: VockifyColors.white,
                      fontSize: 16,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefinitionChips() {
    return Wrap(
      spacing: 8,
      children: _definitions.map((definition) {
        return ChoiceChip(
          backgroundColor: VockifyColors.white,
          selectedColor: VockifyColors.lightSteelBlue,
          label: Text(definition),
          labelStyle: TextStyle(color: VockifyColors.black),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: VockifyColors.lightSteelBlue,
            ),
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          selected: _selectedDefinitions.contains(definition),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _selectedDefinitions.add(definition);
              } else {
                _selectedDefinitions.remove(definition);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Future<void> _translate() async {
    if (_nameController.text.isEmpty || _nameController.text == _term) {
      return;
    }

    try {
      final data = await api.translate(TranslateRequestDto(_nameController.text));

      _selectedDefinitions.clear();

      setState(() {
        _term = data.data.term;
        _transcription = data.data.transcription;
        _definitions = data.data.definitions;
      });
    } catch (e) {
      print(e);
    }
  }
}
