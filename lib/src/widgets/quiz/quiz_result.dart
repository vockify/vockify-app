import 'package:vockify/src/redux/state/term_state/term_state.dart';

class QuizResult {
  final List<TermState> terms;
  final List<int> wrongIds;

  QuizResult({this.terms, this.wrongIds});
}
