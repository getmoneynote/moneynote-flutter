import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';
import '/charts/index.dart';

part 'chart_income_category_event.dart';
part 'chart_income_category_state.dart';


class ChartIncomeCategoryBloc extends Bloc<ChartIncomeCategoryEvent, ChartIncomeCategoryState> {

  ChartIncomeCategoryBloc() : super(const ChartIncomeCategoryState()) {
    on<ChartIncomeCategoryInitial>(_onInitial);
    on<ChartIncomeCategoryReloaded>(_onReloaded);
    on<ChartIncomeCategoryQueryChanged>(_onQueryChanged);
  }

  void _onInitial(event, emit) async {
    emit(state.copyWith(
      query: { ...?event.query },
      status: LoadDataStatus.initial,
      data: [],
    ));
    add(ChartIncomeCategoryReloaded());
  }

  void _onReloaded(_, emit) async {
    try {
      emit(state.copyWith(
        status: LoadDataStatus.progress,
      ));
      final data = await ChartRepository.incomeCategory({
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

  void _onQueryChanged(event, emit) async {
    emit(state.copyWith(
      query: {...state.query, ...event.query},
    ));
  }

}
