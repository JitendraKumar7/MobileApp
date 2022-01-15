part of 'forgot_cubit.dart';

class ForgotState extends Equatable {
  const ForgotState({
    this.email = const Email.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Email email;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [email,  status];

  ForgotState copyWith({
    Email? email,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return ForgotState(
      email: email ?? this.email,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
