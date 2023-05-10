part of 'chart_expense_category_bloc.dart';

abstract class ChartExpenseCategoryEvent extends Equatable {
  const ChartExpenseCategoryEvent();
  @override
  List<Object?> get props => [];
}

class ChartExpenseCategoryInitial extends ChartExpenseCategoryEvent {
  const ChartExpenseCategoryInitial({
    this.query
  });
  final Map<String, dynamic>? query;
  @override
  List<Object?> get props => [query];
}

class ChartExpenseCategoryQueryChanged extends ChartExpenseCategoryEvent {
  const ChartExpenseCategoryQueryChanged(this.query);
  final Map<String, dynamic> query;
  @override
  List<Object> get props => [query];
}

class ChartExpenseCategoryReloaded extends ChartExpenseCategoryEvent { }
