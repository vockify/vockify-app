import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/terms/term_dto.dart';
import 'package:vockify/src/api/dto/translate/translate_request_dto.dart';
import 'package:vockify/src/redux/actions/terms/request_add_user_term_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/add_user_term/user_term_text_field.dart';
import 'package:vockify/src/widgets/common/form_dropdown.dart';

class AddUserTermWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddUserTermState();
}

class _AddUserTermState extends State<AddUserTermWidget> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<String> _definitions = [];

  final List<String> _selectedDefinitions = [];

  String _transcription = '';

  int _selectedSetId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: UserTermTextFieldWidget(
                  controller: _nameController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  _transcription,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 20,
                      ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: _buildDefinitionChips(),
                ),
              ),
              _buildSetsDropdown(),
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

    final state = StoreProvider.of<AppState>(context, listen: false).state;
    _selectedSetId = getUserSetIds(state).first;

    _nameController.addListener(() {
      EasyDebounce.debounce(
        'translate',
        Duration(milliseconds: 500),
        _handleChangeName,
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
              fillColor: VockifyColors.green,
              onPressed: () {
                dispatcher.dispatch(RequestAddUserTermAction(
                  term: TermDto(
                    id: 0,
                    name: _nameController.text,
                    setId: _selectedSetId,
                    definition: definition,
                  ),
                ));
              },
              child: Text(
                'Сохранить',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: VockifyColors.black,
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
          label: Text(definition),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          selected: _selectedDefinitions.contains(definition),
          visualDensity: VisualDensity.compact,
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

  Widget _buildSetsDropdown() {
    if (_definitions.isEmpty) {
      return Container();
    }

    return StoreConnector<AppState, List<SetState>>(
      distinct: true,
      converter: (store) {
        final items = getSetItems(store.state);
        return getUserSetIds(store.state).map((id) => items[id]).toList();
      },
      builder: (context, sets) {
        return FormDropdownWidget(
          items: sets.map((set) => FormDropdownItem(set.id, set.name)),
          selectedId: _selectedSetId,
          onChanged: (id) {
            setState(() {
              _selectedSetId = id;
            });
          },
        );
      },
    );
  }

  Future<void> _handleChangeName() async {
    if (_nameController.text.isEmpty) {
      if (_definitions.isNotEmpty || _transcription.isNotEmpty) {
        setState(() {
          _definitions = [];
          _transcription = '';
        });
      }

      return;
    }

    try {
      final data = await api.translate(TranslateRequestDto(_nameController.text));

      _selectedDefinitions.clear();

      setState(() {
        _definitions = data.data.definitions;
        _transcription = data.data.transcription;
      });
    } catch (e) {
      print(e);
    }
  }
}
