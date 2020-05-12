import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/common/layout_button_wrapper.dart';
import 'package:vockify/src/widgets/quiz/quiz_controller.dart';
import 'package:vockify/src/widgets/quiz/quiz_step.dart';
import 'package:vockify/src/widgets/sets.dart';

class QuizWidget extends StatefulWidget {
  static const String route = '/quiz';

  @override
  State<StatefulWidget> createState() => _QuizState();
}

class _QuizState extends State<QuizWidget> {
  final QuizController _controller = QuizController();

  QuizStep _step;
  String _correctDefinition;
  String _selectedDefinition;
  Timer _selectDefinitionTimer;

  @override
  void didUpdateWidget(QuizWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (_step == null) {
      return AppLayoutWidget(
        title: 'Quiz',
        body: Center(
          child: Text('Add a terms before start quiz'),
        ),
        redirectBackRoute: SetsWidget.route,
      );
    }

    return AppLayoutWidget(
      title: 'Quiz',
      body: StoreConnector<AppState, QuizStep>(
        converter: (store) => QuizStep.mock(),
        builder: (context, viewModel) {
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                  color: Colors.white70,
                  child: ListTile(
                    title: Center(
                      child: Text(_step.term),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Center(
                  child: Text('Choose definition'),
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
                        title: Center(child: Text(definition)),
                      ),
                    );
                  },
                ),
              ),
              ListTile(
                title: Text(
                  '${_step.termIndex + 1} / ${_step.termsCount}',
                  textAlign: TextAlign.center,
                ),
              ),
              LayoutButtonWrapperWidget(
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: _stop,
                  color: Colors.red,
                  child: Text(
                    'Stop',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
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
    _step = _controller.getStep();
  }

  Color _getDefinitionColor(String definition) {
    if (definition == _correctDefinition) {
      return Colors.lightGreen;
    } else if (definition == _selectedDefinition) {
      return Colors.deepOrange;
    }

    return Colors.orangeAccent;
  }

  void _selectDefinition(String definition) {
    if (_selectDefinitionTimer?.isActive ?? false) {
      return;
    }

    final correctDefinition = _controller.getCorrectDefinition();

    setState(() {
      _correctDefinition = correctDefinition;
      _selectedDefinition = definition;
    });

    _selectDefinitionTimer?.cancel();
    _selectDefinitionTimer = Timer(Duration(seconds: 1), () {
      _controller.next();
      final step = _controller.getStep();

      if (step != null) {
        setState(() {
          _step = step;
          _correctDefinition = null;
          _selectedDefinition = null;
        });
      } else {
        final store = StoreProvider.of<AppState>(context);
        store.dispatch(NavigateToAction.replace('/sets'));
      }
    });
  }

  void _stop() {
    _selectDefinitionTimer?.cancel();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(NavigateToAction.replace('/sets'));
  }
}
