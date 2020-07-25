class QuizStep {
  final int termId;
  final String name;
  final List<String> definitions;
  final int termsCount;
  final int termIndex;
  final int correctCount;

  QuizStep({
    this.termId,
    this.name,
    this.definitions,
    this.termsCount,
    this.termIndex,
    this.correctCount,
  });
}
