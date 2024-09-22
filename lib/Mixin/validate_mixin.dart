mixin ValidateMixin {
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Name";
    }
    if (value.length > 100) {
      return "Name is not Valid";
    }
    return null;
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Mobile Number";
    }
    if (value.length > 10 || value.length < 10) {
      return "Mobile Number is not Valid";
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Email ID";
    }
    var regEx = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (regEx.hasMatch(value)) {
      return "Email is not Valid";
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // Check length
    if (value.length < 8 || value.length > 16) {
      return 'Password must be between 8 and 16 characters';
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one digit
    if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }

    // Check for at least one special character
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }
}
