part of 'account_form_bloc.dart';

abstract class AccountFormEvent extends Equatable {
  const AccountFormEvent();
  @override
  List<Object> get props => [];
}

class FieldChanged extends AccountFormEvent {
  const FieldChanged(this.field);
  final Map<String, dynamic> field;
  @override
  List<Object> get props => [field];
}

class NameChanged extends AccountFormEvent {
  const NameChanged(this.name);
  final String name;
  @override
  List<Object> get props => [name];
}

class BalanceChanged extends AccountFormEvent {
  const BalanceChanged(this.balance);
  final String balance;
  @override
  List<Object> get props => [balance];
}

class DefaultLoaded extends AccountFormEvent {
  final int action;
  final String type;
  final Map<String, dynamic> currentRow;
  const DefaultLoaded(this.action, this.type, this.currentRow);
  @override
  List<Object> get props => [type, action, currentRow];
}

class Submitted extends AccountFormEvent { }


