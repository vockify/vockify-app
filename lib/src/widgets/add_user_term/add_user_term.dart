import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/sets/set_dto.dart';
import 'package:vockify/src/api/dto/terms/term_dto.dart';
import 'package:vockify/src/api/dto/translate/translate_request_dto.dart';
import 'package:vockify/src/redux/actions/terms/request_add_user_term_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/widgets/common/form_dropdown.dart';
import 'package:vockify/src/widgets/common/form_text_field.dart';
import 'package:vockify/src/widgets/common/primary_button.dart';

class AddUserTermWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddUserTermState();
}

class _AddUserTermState extends State<AddUserTermWidget> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  List<String> _definitions = [];

  final List<String> _selectedDefinitions = [];

  String _transcription = '';

  int _selectedSetId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FormTextFieldWidget(
              controller: _nameController,
              text: 'ВВЕДИТЕ СЛОВО',
            ),
            Text(_transcription),
            _buildDefinitionChips(),
            _buildSetsDropdown(),
            _buildAddButton(),
          ],
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

    return PrimaryButtonWidget(
      text: 'Сохранить',
      onPressed: () {
        dispatcher.dispatch(RequestAddUserTermAction(
          term: TermDto(
            id: 0,
            name: _nameController.text,
            setId: _selectedSetId,
            definition: _selectedDefinitions.join(', '),
          ),
        ));
      },
    );
  }

  Widget _buildDefinitionChips() {
    return Wrap(
      children: _definitions.map((definition) {
        return ChoiceChip(
          label: Text(definition),
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
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final data = await api.translate(TranslateRequestDto(_nameController.text));

      _selectedDefinitions.clear();

      setState(() {
        _definitions = data.data.definitions;
        _transcription = data.data.transcription;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
