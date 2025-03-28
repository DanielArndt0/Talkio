class CloudException implements Exception {
  final String message;
  final String code;

  CloudException({
    required this.message,
    required this.code,
  });

  @override
  String toString() {
    return "Error: $message";
  }

  String get getCode => code;
}
