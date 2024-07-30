class UsernameValidationUseCase {
  bool validateUsername(String username) {
    final RegExp alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
    return username.length >= 8 && alphanumeric.hasMatch(username);
  }
}
