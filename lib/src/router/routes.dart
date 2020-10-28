class Routes {
  // app routes
  static const String app = "/";
  static const String tour = "/tour";
  static const String home = "/home/:intent";
  static const String login = "/login";
  static const String quiz = "/quiz/:setId";

  // home routes
  static const String start = "/start";
  static const String main = "/main";
  static const String profile = "/profile";

  // user set routes
  static const String userSet = "/user_set";
  static const String userSetSelect = '/user_set_select';
  
  // user term routes
  static const String userTerms = "/user_terms";
  static const String userTerm = "/user_term";

  // public term routes
  static const String publicTerms = "/public_terms";
}
