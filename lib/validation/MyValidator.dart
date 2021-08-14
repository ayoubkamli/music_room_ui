class MyInputValidator {
  bool isPasswordValid(String password) {
    if (password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length > 7;

    return hasDigits &
        hasUppercase &
        hasLowercase &
        hasSpecialCharacters &
        hasMinLength;
  }

  bool validateEmail(String email) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    return RegExp(pattern).hasMatch(email);
  }

  bool isEventNameValid(String eventName) {
    return eventName.length > 3;
  }

  bool isEventdescriptionValid(String eventDescription) {
    return eventDescription.length > 3;
  }

  bool isEventStatusValid(String eventStatus) {
    return (eventStatus == 'public' || eventStatus == 'privat');
  }

  bool isPrefListValid(List<String> pref) {
    return pref.length > 0;
  }
}
