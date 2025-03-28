class AuthException implements Exception {
  final String message;
  final String code;

  AuthException({
    required this.message,
    required this.code,
  });

  @override
  String toString() {
    return "Error: $message";
  }

  String get getCode => code;
}
