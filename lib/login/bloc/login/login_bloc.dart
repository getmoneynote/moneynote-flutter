import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '/commons/index.dart';
import '/login/index.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc({
    required this.authBloc
  }) : super(const LoginState()) {
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<WeChatLogIn>(_onWeChatLogIn);
  }

  final AuthBloc authBloc;

  void _onUsernameChanged(UsernameChanged event, Emitter<LoginState> emit) {
    final username = NotEmptyFormz.dirty(value: event.username);
    emit(state.copyWith(
      usernameFormz: username,
      valid: Formz.validate([username, state.passwordFormz]),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final password = NotEmptyFormz.dirty(value: event.password);
    emit(state.copyWith(
      passwordFormz: password,
      valid: Formz.validate([password, state.usernameFormz]),
    ));
  }

  void _onLoginButtonPressed(_, Emitter<LoginState> emit) async {
    if (state.valid) {
      try {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
        String token = await LoginRepository.logIn(username: state.usernameFormz.value, password: state.passwordFormz.value);
        authBloc.add(LoggedIn(token));
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
      }
    }
  }

  void _onWeChatLogIn(event, emit) async {
    try {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      String token = await LoginRepository.wechatCallBack(code: event.code, state: event.state);
      authBloc.add(LoggedIn(token));
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
    }
  }

}