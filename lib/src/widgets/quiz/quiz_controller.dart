import 'package:vockify/src/redux/state/term_state/memorization_level.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';
import 'package:vockify/src/widgets/quiz/quiz_result.dart';
import 'package:vockify/src/widgets/quiz/quiz_step.dart';
import 'package:vockify/src/widgets/quiz/quiz_step_result.dart';

class QuizController {
  static const _roundTermsCount = 10;

  int _index = 0;
  List<TermState> _terms = [];
  int _correctCount = 0;
  List<int> _wrongIds = [];

  QuizStep getNextStep() {
    next();
    return getStep();
  }

  QuizResult getResult() {
    final termIds = _terms.map((term) => term.id).toList();

    termIds.sort((a, b) {
      if (_wrongIds.contains(a) && !_wrongIds.contains(b)) {
        return -1;
      }

      if (!_wrongIds.contains(a) && _wrongIds.contains(b)) {
        return 1;
      }

      return 0;
    });

    return QuizResult(termIds: termIds, wrongIds: _wrongIds);
  }

  QuizStep getStep() {
    if (_index > _terms.length - 1) {
      return null;
    }

    final term = _terms[_index];

    final step = QuizStep(
      termId: term.id,
      name: term.name,
      definitions: _getStepDefinitions(),
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
    _terms = _getRoundTerms(terms);
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

  List<TermState> _getRoundTerms(List<TermState> terms) =>
      _getSortedTerms(terms).take(_roundTermsCount).toList()..shuffle();

  List<TermState> _getSortedTerms(List<TermState> terms) {
    final sorted = terms.toList();
    sorted.shuffle();
    sorted.sort((a, b) => MemorizationLevel.compare(a.memorizationLevel, b.memorizationLevel));
    return sorted;
  }

  List<String> _getStepDefinitions() {
    final terms = _terms.toList();
    terms.removeAt(_index);
    terms.shuffle();

    final definitions = [_terms[_index].definition, ...terms.take(3).map((term) => term.definition)];
    definitions.shuffle();

    return definitions;
  }
}
