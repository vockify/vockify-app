import 'package:vockify/src/redux/state/term_state.dart';
import 'package:vockify/src/widgets/quiz/quiz_step.dart';
import 'package:vockify/src/widgets/quiz/quiz_step_result.dart';

class QuizController {
  int _index = 0;
  List<TermState> _terms = [];
  int _correctCount = 0;

  QuizStep getNextStep() {
    next();
    return getStep();
  }

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
      correctCount: _correctCount,
    );

    return step;
  }

  QuizStepResult getStepResult(String definition) {
    final term = _terms[_index];

    if (definition == term.definition) {
      _correctCount++;
    }

    final wrongCount = _index - _correctCount + 1;

    return QuizStepResult(
      correctCount: _correctCount,
      wrongCount: wrongCount,
      correctDefinition: term.definition,
    );
  }

  int getTermsCount() => _terms.length;

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
