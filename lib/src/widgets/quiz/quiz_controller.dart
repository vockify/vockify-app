import 'package:vockify/src/redux/state/term_state.dart';
import 'package:vockify/src/widgets/quiz/quiz_step.dart';
import 'package:vockify/src/widgets/quiz/quiz_step_result.dart';

class QuizController {
  int _index = 0;
  List<TermState> _terms = [];

  QuizStep getStep() {
    if (_index > _terms.length - 1) {
      return null;
    }

    final term = _terms[_index];
    final step = QuizStep(
      term: term.name,
      definitions: _getDefinitions(),
      termIndex: _index,
      termsCount: _terms.length,
    );

    return step;
  }

  String getCorrectDefinition() => _terms[_index].definition;

  QuizStepResult getStepResult(String definition) => QuizStepResult(_terms[_index].definition, getStep());

  void next() {
    _index++;
  }

  void start(List<TermState> terms) {
    _terms = terms.toList();
    _terms.shuffle();
    _index = 0;
  }

  void stop() {
    _terms = [];
    _index = 0;
  }

  List<String> _getDefinitions() {
    final terms = _terms.toList();
    terms.removeAt(_index);
    terms.shuffle();

    final definitions = [_terms[_index].definition, ...terms.take(3).map((term) => term.definition)];
    definitions.shuffle();

    return definitions;
  }
}
