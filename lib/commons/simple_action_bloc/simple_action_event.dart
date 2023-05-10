part of 'simple_action_bloc.dart';

abstract class SimpleActionEvent extends Equatable {
  const SimpleActionEvent();
  @override
  List<Object> get props => [];
}

class SimpleActionReloaded extends SimpleActionEvent {

  const SimpleActionReloaded({
    required this.uri,
  });

  final String uri;

  @override
  List<Object> get props => [uri];

}