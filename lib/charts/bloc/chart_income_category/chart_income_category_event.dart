part of 'chart_income_category_bloc.dart';

abstract class ChartIncomeCategoryEvent extends Equatable {
  const ChartIncomeCategoryEvent();
  @override
  List<Object?> get props => [];
}

class ChartIncomeCategoryInitial extends ChartIncomeCategoryEvent {
  const ChartIncomeCategoryInitial({
    this.query
  });
  final Map<String, dynamic>? query;
  @override
  List<Object?> get props => [query];
}

class ChartIncomeCategoryQueryChanged extends ChartIncomeCategoryEvent {
  const ChartIncomeCategoryQueryChanged(this.query);
  final Map<String, dynamic> query;
  @override
  List<Object> get props => [query];
}

class ChartIncomeCategoryReloaded extends ChartIncomeCategoryEvent { }
