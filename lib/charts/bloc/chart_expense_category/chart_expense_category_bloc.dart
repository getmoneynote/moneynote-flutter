import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';
import '/charts/index.dart';

part 'chart_expense_category_event.dart';
part 'chart_expense_category_state.dart';


class ChartExpenseCategoryBloc extends Bloc<ChartExpenseCategoryEvent, ChartExpenseCategoryState> {

  ChartExpenseCategoryBloc() : super(const ChartExpenseCategoryState()) {
    on<ChartExpenseCategoryInitial>(_onInitial);
    on<ChartExpenseCategoryReloaded>(_onReloaded);
    on<ChartExpenseCategoryQueryChanged>(_onQueryChanged);
  }

  void _onInitial(ChartExpenseCategoryInitial event, Emitter<ChartExpenseCategoryState> emit) async {
    emit(state.copyWith(
      query: { ...?event.query },
      status: LoadDataStatus.initial,
      data: [],
    ));
    add(ChartExpenseCategoryReloaded());
  }

  void _onReloaded(_, Emitter<ChartExpenseCategoryState> emit) async {
    try {
      emit(state.copyWith(
        status: LoadDataStatus.progress,
      ));
      final data = await ChartRepository.expenseCategory({
        ...state.query,
        'categories': List<int>.from(state.query['categories']?.map((e) => e['value']) ?? [ ]),
        'tags': List<int>.from(state.query['tags']?.map((e) => e['value']) ?? [ ]),
      });
      emit(state.copyWith(
        status: LoadDataStatus.success,
        data: data,
      ));
    } catch (_) {
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

  void _onQueryChanged(ChartExpenseCategoryQueryChanged event, Emitter<ChartExpenseCategoryState> emit) async {
    emit(state.copyWith(
      query: {...state.query, ...event.query},
    ));
  }

}
