class QuizStep {
  final int termId;
  final String name;
  final List<String> definitions;
  final int termsCount;
  final int termIndex;
  final int correctCount;

  QuizStep({
    required this.termId,
    required this.name,
    required this.definitions,
    required this.termsCount,
    required this.termIndex,
    required this.correctCount,
  });
}
