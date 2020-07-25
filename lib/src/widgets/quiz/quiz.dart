import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/api/dto/terms/term_dto.dart';
import 'package:vockify/src/redux/actions/terms/request_update_term_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state/memorization_level.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/quiz/quiz_controller.dart';
import 'package:vockify/src/widgets/quiz/quiz_result.dart';
import 'package:vockify/src/widgets/quiz/quiz_step.dart';
import 'package:vockify/src/widgets/quiz_result/quiz_result.dart';

class QuizWidget extends StatefulWidget {
  final Iterable<int> ids;

  const QuizWidget({Key key, this.ids}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuizState();
}

class _QuizState extends State<QuizWidget> {
  final QuizController _controller = QuizController();

  QuizStep _step;
  QuizResult _result;

  String _selectedDefinition;
  String _correctDefinition;

  bool _isFinished;

  Timer _selectDefinitionTimer;

  @override
  Widget build(BuildContext context) {
    if (_isFinished) {
      return QuizResultWidget(
        result: _result,
        onPressContinue: _continue,
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              child: ListTile(
                title: Center(
                  child: Text(
                    _step.name,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 18,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 280,
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            physics: new NeverScrollableScrollPhysics(),
            itemCount: _step.definitions.length,
            itemBuilder: (BuildContext context, int index) {
              final definition = _step.definitions[index];

              return Card(
                color: _getDefinitionColor(definition),
                child: ListTile(
                  onTap: () {
                    _selectDefinition(definition);
                  },
                  title: Center(
                    child: Text(
                      definition,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: _getDefinitionTextColor(definition),
                            fontSize: 18,
                          ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    _start();
    super.initState();
  }

  void _continue() {
    setState(_start);
  }

  Color _getDefinitionColor(String definition) {
    if (definition == _correctDefinition) {
      return VockifyColors.green;
    } else if (definition == _selectedDefinition) {
      return VockifyColors.flame;
    }

    return VockifyColors.lightSteelBlue;
  }

  Color _getDefinitionTextColor(String definition) {
    if (definition == _correctDefinition || definition == _selectedDefinition) {
      return VockifyColors.white;
    }

    return VockifyColors.prussianBlue;
  }

  void _selectDefinition(String definition) {
    if (_selectDefinitionTimer?.isActive ?? false) {
      return;
    }

    final stepResult = _controller.getStepResult(definition);

    setState(() {
      _correctDefinition = stepResult.correctDefinition;
      _selectedDefinition = definition;
    });

    _update();

    _selectDefinitionTimer?.cancel();
    _selectDefinitionTimer = Timer(Duration(seconds: 1), () {
      final step = _controller.getNextStep();

      if (step != null) {
        setState(() {
          _step = step;
          _correctDefinition = null;
          _selectedDefinition = null;
        });
      } else {
        setState(() {
          _isFinished = true;
          _result = _controller.getResult();
        });
      }
    });
  }

  void _start() {
    final store = StoreProvider.of<AppState>(context, listen: false);
    final terms = widget.ids.map((id) => getTermById(store.state, id)).toList();

    _controller.start(terms);
    _step = _controller.getStep();

    _correctDefinition = null;
    _selectedDefinition = null;

    _isFinished = false;
  }

  void _update() {
    final store = StoreProvider.of<AppState>(context, listen: false);
    final term = getTermById(store.state, _step.termId);

    final memorizationLevel = _selectedDefinition == _correctDefinition
        ? MemorizationLevel.up(term.memorizationLevel)
        : MemorizationLevel.down(term.memorizationLevel);

    if (memorizationLevel != term.memorizationLevel) {
      dispatcher.dispatch(RequestUpdateUserTermAction(
        term: TermDto.fromState(term.rebuild((builder) {
          builder.memorizationLevel = memorizationLevel;
        })),
      ));
    }
  }
}
