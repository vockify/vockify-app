import 'package:vockify/src/redux/state/term_state/term_state.dart';

class QuizResult {
  final List<int> termIds;
  final List<int> wrongIds;

  QuizResult({this.termIds, this.wrongIds});
}
