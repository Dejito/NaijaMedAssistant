
class AuthValidator {

  static String? validateUsername(String? username) {
    if (username==null || username.isEmpty) {
      return 'Username is required.';
    }
    else if (username.length < 3) {
      return 'Minimum length for username is 3';
    }
    else if (!RegExp(r'^[A-Za-z]').hasMatch(username)) {
      return 'Username must start with a letter.';
    }
    else if (!RegExp(r'^[A-Za-z][A-Za-z0-9_]*$').hasMatch(username)) {
      return 'Username can only contain letters, numbers, and underscores.';
    }
    return null;
  }

  static String? validateFullName(String? fullName) {
    if (fullName==null || fullName.isEmpty) {
      return 'Name is required.';
    }
    else if (fullName.length < 7) {
      return 'Atleast 3 characters';
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty.';
    }
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required.';
    }

    if (password.length < 8) {
      return 'At least 8 characters.';
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Include an uppercase letter.';
    }

    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Include a lowercase letter.';
    }

    if (!RegExp(r'\d').hasMatch(password)) {
      return 'Include a number.';
    }

    if (!RegExp(r'[!@#\$&*~%^()_\-+=<>?/.,]').hasMatch(password)) {
      return 'Include a special character.';
    }

    return null;
  }

  static String? validateConfirmPassword(String? confirmPassword, String? originalPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password.';
    }

    if (confirmPassword != originalPassword) {
      return 'Passwords do not match.';
    }

    return null;
  }

  static String? validatePhoneNumber(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Phone number cannot be empty.';
    }
    final RegExp phoneRegex = RegExp(
      r'^(?:\+?234|0)[789][01]\d{8}$',
    );
    if (!phoneRegex.hasMatch(phone)) {
      return 'Please enter a valid Nigerian phone number.';
    }
    return null;
  }



}

