part of 'simple_action_bloc.dart';

class SimpleActionState extends Equatable {

  final String uri;
  final LoadDataStatus status;

  const SimpleActionState({
    this.uri = '',
    this.status = LoadDataStatus.initial,
  });

  SimpleActionState copyWith({
    String? uri,
    LoadDataStatus? status,
  }) {
    return SimpleActionState(
      uri: uri ?? this.uri,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [uri, status];

}