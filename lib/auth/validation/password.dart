import 'package:formz/formz.dart';

enum PasswordValidationError {
  invalid,
  empty,
}

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegExp = RegExp(r'^[A-Za-z\d@$!%*?&]{8,}$');

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    }
    return _passwordRegExp.hasMatch(value)
        ? null
        : PasswordValidationError.invalid;
  }
}

extension Explanation on PasswordValidationError {
  dynamic get name {
    switch (this) {
      case PasswordValidationError.invalid:
        return "Password must have at least 8 characters lawer, uper case digit and symbole";
      default:
        return null;
    }
  }
}
