part of 'chart_income_category_bloc.dart';

class ChartIncomeCategoryState extends Equatable {

  final LoadDataStatus status;
  final List<Map<String, dynamic>> data;
  final Map<String, dynamic> query;

  const ChartIncomeCategoryState({
    this.status = LoadDataStatus.initial,
    this.data = const [ ],
    this.query = const { },
  });

  ChartIncomeCategoryState copyWith({
    LoadDataStatus? status,
    List<Map<String, dynamic>>? data,
    Map<String, dynamic>? query,
  }) {
    return ChartIncomeCategoryState(
      status: status ?? this.status,
      data: data ?? this.data,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [status, data, query];

}