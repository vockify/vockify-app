import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/common/app_button_bar.dart';
import 'package:vockify/src/widgets/quiz/quiz_controller.dart';
import 'package:vockify/src/widgets/quiz/quiz_step.dart';

class QuizWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QuizState();
}

class _QuizState extends State<QuizWidget> {
  final QuizController _controller = QuizController();

  QuizStep _step;

  int _termsCount;

  int _correctCount = 0;
  int _wrongCount = 0;

  String _selectedDefinition;
  String _correctDefinition;

  bool _isFinished = false;

  Timer _selectDefinitionTimer;

  @override
  Widget build(BuildContext context) {
    if (_step == null) {
      return AppLayoutWidget(
        title: 'Quiz',
        body: Center(
          child: Text('Add a terms before start quiz'),
        ),
      );
    }

    if (_isFinished) {
      return AppLayoutWidget(
        title: 'Quiz',
        body: Center(
          child: Text('Your result: ${_correctCount} / $_termsCount'),
        ),
      );
    }

    return AppLayoutWidget(
      title: 'Quiz',
      body: StoreConnector<AppState, QuizStep>(
        converter: (store) => null,
        builder: (context, viewModel) {
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                  color: VockifyColors.grey,
                  child: ListTile(
                    title: Center(
                      child: Text(_step.term),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Center(
                  child: Text('CHOOSE DEFINITION'),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
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
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Wrong: ${_wrongCount}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: VockifyColors.prussianBlue,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Correct: ${_correctCount}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: VockifyColors.prussianBlue,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Total: ${_termsCount}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: VockifyColors.prussianBlue,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              AppButtonBarWidget(
                children: [
                  RaisedButton(
                    shape: Border(),
                    color: VockifyColors.flame,
                    onPressed: _stop,
                    child: Text(
                      'STOP',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: VockifyColors.ghostWhite,
                            fontSize: 16,
                          ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    final store = StoreProvider.of<AppState>(context, listen: false);

    _controller.start(store.state.terms.toList());
    _termsCount = _controller.getTermsCount();
    _step = _controller.getStep();
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
      _correctCount = stepResult.correctCount;
      _wrongCount = stepResult.wrongCount;
      _correctDefinition = stepResult.correctDefinition;
      _selectedDefinition = definition;
    });

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
        });
      }
    });
  }

  void _stop() {
    _selectDefinitionTimer?.cancel();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(NavigateToAction.pop());
  }
}
