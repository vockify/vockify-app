import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/common/app_button_bar.dart';
import 'package:vockify/src/widgets/quiz/quiz_controller.dart';
import 'package:vockify/src/widgets/quiz/quiz_result.dart';
import 'package:vockify/src/widgets/quiz/quiz_step.dart';

class QuizWidget extends StatefulWidget {
  final Iterable<TermState> terms;

  const QuizWidget({Key key, this.terms}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuizState();
}

class _QuizState extends State<QuizWidget> {
  final QuizController _controller = QuizController();

  QuizStep _step;
  QuizResult _result;

  int _stepsCount;

  int _correctCount;
  int _wrongCount;

  String _selectedDefinition;
  String _correctDefinition;

  bool _isFinished;

  Timer _selectDefinitionTimer;

  Store<AppState> _store;

  @override
  Widget build(BuildContext context) {
    if (_step == null) {
      return AppLayoutWidget(
        title: 'QUIZ',
        body: Center(
          child: Text('Add terms before starting quiz'),
        ),
      );
    }

    if (_isFinished) {
      return _buildResult();
    }

    return AppLayoutWidget(
      title: 'QUIZ',
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              color: VockifyColors.lightSteelBlue,
              child: ListTile(
                title: Center(
                  child: Text(
                    _step.term,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 18,
                        ),
                  ),
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
          _buildInfo(),
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
      ),
    );
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(_start);
  }

  @override
  void initState() {
    super.initState();

    _store = StoreProvider.of<AppState>(context, listen: false);
    _start();
  }

  Widget _buildInfo() {
    return Container(
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
            'Total: ${_stepsCount}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: VockifyColors.prussianBlue,
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    return AppLayoutWidget(
      title: 'QUIZ',
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
            child: Text(
              _wrongCount == 0 ? 'You AWESOME!' : 'You can do better\nTry again!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _result.terms.length,
              itemBuilder: (BuildContext context, int index) {
                final term = _result.terms[index];
                final isWrong = _result.wrongIds.contains(term.id);

                return Card(
                  color: isWrong ? VockifyColors.flame : VockifyColors.lightSteelBlue,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Text(
                            term.name,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText2.copyWith(
                                  color: isWrong ? VockifyColors.white : VockifyColors.prussianBlue,
                                  fontSize: 18,
                                ),
                          ),
                        ),
                        isWrong ? Icon(Icons.close) : Icon(Icons.check),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _buildInfo(),
          AppButtonBarWidget(
            children: [
              RaisedButton(
                shape: Border(),
                color: VockifyColors.green,
                onPressed: _retry,
                child: Text(
                  'RETRY',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: VockifyColors.ghostWhite,
                        fontSize: 16,
                      ),
                ),
              ),
            ],
          )
        ],
      ),
    );
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

  void _retry() {
    setState(_start);
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
          _result = _controller.getResult();
        });
      }
    });
  }

  void _start() {
    _controller.start(widget.terms.toList());
    _stepsCount = _controller.getStepsCount();
    _step = _controller.getStep();

    _correctCount = 0;
    _wrongCount = 0;

    _correctDefinition = null;
    _selectedDefinition = null;

    _isFinished = false;
  }

  void _stop() {
    _selectDefinitionTimer?.cancel();
    _store.dispatch(NavigateToAction.pop());
  }
}
