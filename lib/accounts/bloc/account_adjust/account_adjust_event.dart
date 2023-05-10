part of 'account_adjust_bloc.dart';

abstract class AccountAdjustEvent extends Equatable {
  const AccountAdjustEvent();
  @override
  List<Object> get props => [];
}

class AdjustFieldChanged extends AccountAdjustEvent {
  const AdjustFieldChanged(this.field);
  final Map<String, dynamic> field;
  @override
  List<Object> get props => [field];
}

class AdjustBalanceChanged extends AccountAdjustEvent {
  const AdjustBalanceChanged(this.value);
  final String value;
  @override
  List<Object> get props => [value];
}

class AdjustDefaultLoaded extends AccountAdjustEvent {
  final int action;
  final Map<String, dynamic> currentRow;
  const AdjustDefaultLoaded(this.action, this.currentRow);
  @override
  List<Object> get props => [action, currentRow];
}

class AdjustSubmitted extends AccountAdjustEvent { }


