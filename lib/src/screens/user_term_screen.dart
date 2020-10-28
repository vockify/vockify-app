import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/terms/term_dto.dart';
import 'package:vockify/src/api/dto/translate/translate_request_dto.dart';
import 'package:vockify/src/redux/actions/terms/request_add_user_term_action.dart';
import 'package:vockify/src/redux/actions/terms/request_update_user_term_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/form_text_field.dart';
import 'package:vockify/src/widgets/common/loader.dart';
import 'package:vockify/src/widgets/layout.dart';

class UserTermScreenWidget extends StatefulWidget {
  final int setId;
  final int termId;

  UserTermScreenWidget({
    @required this.setId,
    @required this.termId,
  });

  @override
  State<StatefulWidget> createState() => _UserTermScreenState();
}

class _UserTermScreenState extends State<UserTermScreenWidget> {
  final _definitionController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      route: Routes.userTerm,
      actions: <Widget>[
        RawMaterialButton(
          constraints: BoxConstraints(
            minWidth: 42,
            minHeight: 42,
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              if (widget.termId != null) {
                dispatcher.dispatch(RequestUpdateUserTermAction(
                  term: TermDto(
                    id: widget.termId,
                    name: _nameController.text,
                    setId: widget.setId,
                    definition: _definitionController.text,
                  ),
                ));
              } else {
                dispatcher.dispatch(RequestAddUserTermAction(
                  term: TermDto(
                    id: 0,
                    name: _nameController.text,
                    setId: widget.setId,
                    definition: _definitionController.text,
                  ),
                ));
              }

              Navigator.of(context).pop();
            }
          },
          child: Text(
            'Сохранить',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: VockifyColors.white,
                  fontSize: 18,
                ),
          ),
          padding: EdgeInsets.all(16),
        ),
      ],
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FormTextFieldWidget(
                controller: _nameController,
                text: 'СЛОВО НА АНГЛИЙСКОМ',
                autoFocus: true,
              ),
              FormTextFieldWidget(
                controller: _definitionController,
                text: 'ПЕРЕВОД',
                suffix: _buildTranslateButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _definitionController.dispose();
    _nameController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    if (widget.termId != null) {
      final store = StoreProvider.of<AppState>(context, listen: false);
      final term = getTermById(store.state, widget.termId);

      _nameController.text = term.name;
      _definitionController.text = term.definition;
    }

    super.initState();
  }

  Widget _buildTranslateButton() {
    if (_isLoading) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: LoaderWidget(),
      );
    }

    return IconButton(
      onPressed: () async {
        if (_nameController.text.isEmpty) {
          return;
        }

        setState(() {
          _isLoading = true;
        });

        try {
          final data = await api.translate(TranslateRequestDto(_nameController.text));

          if (data.data.definitions.isNotEmpty) {
            _definitionController.text = data.data.definitions.first;
          }
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      },
      icon: Icon(Icons.translate),
    );
  }
}
