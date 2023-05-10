part of 'account_overview_bloc.dart';

abstract class AccountOverviewEvent extends Equatable {
  const AccountOverviewEvent();
  @override
  List<Object> get props => [];
}

class AccountOverviewReloaded extends AccountOverviewEvent { }