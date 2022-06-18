import 'package:formz/formz.dart';

/// Validation errors for the [Password] [FormzInput].
enum PasswordValidationError {
  /// Generic invalid error.
  invalid
}

class Password extends FormzInput<String, PasswordValidationError> {
  /// {@macro password}
  const Password.pure() : super.pure('');

  /// {@macro password}
  const Password.dirty([String value = '']) : super.dirty(value);

  //static final _passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{4,}$');

  @override
  PasswordValidationError? validator(String? value) {
    return (value ?? '').isNotEmpty
        ? null
        : PasswordValidationError.invalid;
  }
}
