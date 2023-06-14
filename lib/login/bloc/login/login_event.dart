part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class UsernameChanged extends LoginEvent {
  final String username;
  const UsernameChanged(this.username);
  @override
  List<Object> get props => [username];
}

class PasswordChanged extends LoginEvent {
  final String password;
  const PasswordChanged(this.password);
  @override
  List<Object> get props => [password];
}

class ApiUrlChanged extends LoginEvent {
  final String apiUrl;
  const ApiUrlChanged(this.apiUrl);
  @override
  List<Object> get props => [apiUrl];
}

class LoginButtonPressed extends LoginEvent {
  const LoginButtonPressed();
}

class WeChatLogIn extends LoginEvent {
  final String code;
  final String state;
  const WeChatLogIn(this.code, this.state);
  @override
  List<Object> get props => [code, state];
}