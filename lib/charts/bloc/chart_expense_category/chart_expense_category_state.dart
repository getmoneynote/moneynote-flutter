part of 'chart_expense_category_bloc.dart';

class ChartExpenseCategoryState extends Equatable {

  final LoadDataStatus status;
  final List<Map<String, dynamic>> data;
  final Map<String, dynamic> query;

  const ChartExpenseCategoryState({
    this.status = LoadDataStatus.initial,
    this.data = const [ ],
    this.query = const { },
  });

  ChartExpenseCategoryState copyWith({
    LoadDataStatus? status,
    List<Map<String, dynamic>>? data,
    Map<String, dynamic>? query,
  }) {
    return ChartExpenseCategoryState(
      status: status ?? this.status,
      data: data ?? this.data,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [status, data, query];

}