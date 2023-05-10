part of 'chart_balance_bloc.dart';

class ChartBalanceState extends Equatable {

  final LoadDataStatus status;
  final List<List<Map<String, dynamic>>> data;

  const ChartBalanceState({
    this.status = LoadDataStatus.initial,
    this.data = const [ ],
  });

  ChartBalanceState copyWith({
    LoadDataStatus? status,
    List<List<Map<String, dynamic>>>? data,
  }) {
    return ChartBalanceState(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [status, data];


}