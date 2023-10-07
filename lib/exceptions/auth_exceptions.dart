class AuthException implements Exception {
  final String code;
  final String message;

  AuthException({required this.code, required this.message});
}

class WeakPasswordException extends AuthException {
  WeakPasswordException({required super.code, required super.message});
}

class EmailAlreadyExistException extends AuthException {
  EmailAlreadyExistException({required super.code, required super.message});
}
