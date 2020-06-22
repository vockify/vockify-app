class Routes {
  static const String app = "/";
  static const String tour = "/tour";
  static const String home = "/home";
  static const String login = "/login";
  static const String share = "/share/:term";
  static const String quiz = "/quiz/:setId";

  // home routes
  static const String profile = "/profile";
  static const String search = "/search";
  static const String sets = "/sets";
  static const String set = "/sets/:id";
  static const String terms = "/sets/:id/terms";
  static const String term = "/sets/:setId/terms/:termId";
}
