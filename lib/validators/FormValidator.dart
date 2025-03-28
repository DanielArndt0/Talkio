mixin FormValidator {
  String? isNotEmpty(String? string, {String? message}) {
    final str = string?.trim();
    
    return str == null || str.isEmpty ? (message ?? 'Required Field') : null;
  }

  String? confirmPassword(String? string, String? string2, {String? message}) =>
      string == null || string != string2
          ? (message ?? 'This field must be the same as the password.')
          : null;

  String? combine(List<String? Function()> validators) {
    for (var validator in validators) {
      final validation = validator();
      if (validation != null) return validation;
    }
    return null;
  }
}
