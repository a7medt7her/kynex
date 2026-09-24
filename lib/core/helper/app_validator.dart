class AppValidator {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your email';
    }
    final simpleEmailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!simpleEmailRegex.hasMatch(value)) {
      return 'invalid email';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your password';
    } else if (value.length < 6) {
      return "password can't be less than 6 charater";
    }
    return null;
  }

  static String? passwordConfirmValidator(
    String? value,
    String? currentPassword,
  ) {
    if (value == null || value.isEmpty) {
      return 'Enter your password';
    } else if (value != currentPassword) {
      return "incorrect password";
    }
    return null;
  }

  static String? checkFelid(String? value) {
    if (value == null || value.isEmpty) {
      return 'this felid is required';
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your Phone Number';
    } else if (value.length < 11) {
      return "Invalid Number";
    }
    return null;
  }
}
