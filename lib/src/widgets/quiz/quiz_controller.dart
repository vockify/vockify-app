import 'package:vockify/src/redux/state/term_state/term_state.dart';
import 'package:vockify/src/widgets/quiz/quiz_result.dart';
import 'package:vockify/src/widgets/quiz/quiz_step.dart';
import 'package:vockify/src/widgets/quiz/quiz_step_result.dart';

class QuizController {
  static const stepsCount = 10;

  int _index = 0;
  List<TermState> _terms = [];
  int _correctCount = 0;
  List<int> _wrongIds = [];

  QuizStep getNextStep() {
    next();
    return getStep();
  }

  QuizResult getResult() {
    final terms = _terms.toList();
    terms.sort((a, b) {
      if (_wrongIds.contains(a.id) && !_wrongIds.contains(b.id)) {
        return -1;
      }

      if (!_wrongIds.contains(a.id) && _wrongIds.contains(b.id)) {
        return 1;
      }

      return 0;
    });
    return QuizResult(terms: terms, wrongIds: _wrongIds);
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
    } else {
      _wrongIds.add(term.id);
    }

    final wrongCount = _index - _correctCount + 1;

    return QuizStepResult(
      correctCount: _correctCount,
      wrongCount: wrongCount,
      correctDefinition: term.definition,
    );
  }

  int getStepsCount() => _terms?.length ?? 0;

  void next() {
    _index++;
  }

  void start(List<TermState> terms) {
    _terms = terms.toList()..shuffle();
    _terms = _terms.take(stepsCount).toList();
    _index = 0;
    _correctCount = 0;
    _wrongIds = [];
  }

  void stop() {
    _terms = [];
    _index = 0;
    _correctCount = 0;
    _wrongIds = [];
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
