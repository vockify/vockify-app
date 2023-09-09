class SetFiltersDto {
  final bool isCreatedByUser;

  final List<String> terms;

  SetFiltersDto({
    this.isCreatedByUser = true,
    this.terms = const []
  });

  static String toCommaSeparatedList(List list) => list.join(',');
}
