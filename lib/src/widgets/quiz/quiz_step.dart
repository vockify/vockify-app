class QuizStep {
  final String term;
  final List<String> definitions;
  final int termsCount;
  final int termIndex;

  QuizStep({
    this.term,
    this.definitions,
    this.termsCount,
    this.termIndex,
  });

  factory QuizStep.mock() {
    return QuizStep(
      term: 'Data',
      definitions: ['Погода', 'Ветер', 'Ты пидор', 'Данные'],
      termsCount: 10,
      termIndex: 3,
    );
  }
}
