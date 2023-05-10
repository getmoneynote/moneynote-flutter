part of 'auth_bloc.dart';

enum AuthStatus { uninitialized, authenticated, unauthenticated, loading }

class AuthState extends Equatable {

  final AuthStatus status;
  final Map<String, dynamic> initState;

  const AuthState({
    this.status = AuthStatus.uninitialized,
    this.initState = const { }
  });

  AuthState copyWith({
    AuthStatus? status,
    Map<String, dynamic>? initState,
  }) {
    return AuthState(
      status: status ?? this.status,
      initState: initState ?? this.initState,
    );
  }

  @override
  List<Object?> get props => [status, initState];

}
