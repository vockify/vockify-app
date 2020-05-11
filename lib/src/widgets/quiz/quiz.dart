import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/quiz/quiz_controller.dart';
import 'package:vockify/src/widgets/quiz/quiz_step.dart';

class QuizWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QuizState();
}

class _QuizState extends State<QuizWidget> {
  final QuizController _controller = QuizController();

  QuizStep _step;
  String _correctDefinition;
  String _selectedDefinition;

  @override
  Widget build(BuildContext context) {
    return AppLayoutWidget(
      title: 'Quiz',
      body: StoreConnector<AppState, QuizStep>(
          converter: (store) => QuizStep.mock(),
          builder: (context, viewModel) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: 50,
                    color: Colors.amber,
                    child: Center(child: Text(_step.term)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Choose definition'),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: _step.definitions.length,
                    itemBuilder: (BuildContext context, int index) {
                      final definition = _step.definitions[index];

                      return RaisedButton(
                        onPressed: () => _selectDefinition(definition),
                        color: _getDefinitionColor(definition),
                        child: Center(child: Text(definition)),
                      );
                    },
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: null,
                      child: Text('Stop'),
                    ),
                  ],
                )
              ],
            );
          }),
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
      return Colors.green;
    } else if (definition == _selectedDefinition) {
      return Colors.red;
    }

    return Colors.grey;
  }

  void _selectDefinition(String definition) {
    final correctDefinition = _controller.getCorrectDefinition();

    setState(() {
      _correctDefinition = correctDefinition;
      _selectedDefinition = definition;
    });

    Future.delayed(Duration(seconds: 1), () {
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
}
