part of 'select_options_bloc.dart';

abstract class SelectOptionsEvent extends Equatable {
  const SelectOptionsEvent();
  @override
  List<Object?> get props => [];
}

class SelectOptionsInitial extends SelectOptionsEvent {
  const SelectOptionsInitial({
    required this.prefix,
    this.query,
  });
  final String prefix;
  final Map<String, dynamic>? query;
  @override
  List<Object?> get props => [prefix, query];
}

class SelectOptionsReloaded extends SelectOptionsEvent {
  const SelectOptionsReloaded({
    required this.prefix,
  });
  final String prefix;
  @override
  List<Object?> get props => [prefix];
}

