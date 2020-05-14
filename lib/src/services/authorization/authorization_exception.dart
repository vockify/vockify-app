class AuthorizationException implements Exception {
  final String message;

  const AuthorizationException([this.message]);

  String toString() => 'AuthorizationException: $message';
}
