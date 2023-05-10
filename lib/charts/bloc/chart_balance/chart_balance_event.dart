part of 'chart_balance_bloc.dart';

abstract class ChartBalanceEvent extends Equatable {
  const ChartBalanceEvent();
  @override
  List<Object> get props => [];
}

class ChartBalanceReloaded extends ChartBalanceEvent { }