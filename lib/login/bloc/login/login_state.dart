part of 'login_bloc.dart';

class LoginState extends Equatable {

  final bool valid;
  final FormzSubmissionStatus submissionStatus;
  final NotEmptyFormz usernameFormz;
  final NotEmptyFormz passwordFormz;

  const LoginState({
    this.valid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.usernameFormz = const NotEmptyFormz.pure(),
    this.passwordFormz = const NotEmptyFormz.pure(),
  });

  LoginState copyWith({
    bool? valid,
    FormzSubmissionStatus? submissionStatus,
    NotEmptyFormz? usernameFormz,
    NotEmptyFormz? passwordFormz,
  }) {
    return LoginState(
      valid: valid ?? this.valid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      usernameFormz: usernameFormz ?? this.usernameFormz,
      passwordFormz: passwordFormz ?? this.passwordFormz,
    );
  }

  @override
  List<Object> get props => [valid, submissionStatus, usernameFormz, passwordFormz];

}
