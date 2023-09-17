class SetFiltersDto {
  final bool isCreatedByUser;

  final List<String> terms;

  SetFiltersDto({
    this.isCreatedByUser = true,
    this.terms = const []
  });
}
