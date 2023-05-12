import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';
import '/charts/index.dart';

part 'chart_balance_event.dart';
part 'chart_balance_state.dart';


class ChartBalanceBloc extends Bloc<ChartBalanceEvent, ChartBalanceState> {

  ChartBalanceBloc() : super(const ChartBalanceState()) {
    on<ChartBalanceReloaded>(_onReloaded);
  }

  void _onReloaded(_, emit) async {
    try {
      emit(state.copyWith(
        status: LoadDataStatus.progress,
      ));
      final data = await ChartRepository.balance();
      emit(state.copyWith(
        status: LoadDataStatus.success,
        data: data,
      ));
    } catch (_) {
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

}
