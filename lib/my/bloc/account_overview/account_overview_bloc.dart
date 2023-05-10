import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/my/index.dart';
import '/commons/index.dart';

part 'account_overview_event.dart';
part 'account_overview_state.dart';


class AccountOverviewBloc extends Bloc<AccountOverviewEvent, AccountOverviewState> {

  AccountOverviewBloc() : super(const AccountOverviewState()) {
    on<AccountOverviewReloaded>(_onReloaded);
  }

  void _onReloaded(_, Emitter<AccountOverviewState> emit) async {
    try {
      emit(state.copyWith(
        status: LoadDataStatus.progress,
      ));
      final data = await MyRepository.balanceView();
      emit(state.copyWith(
        status: LoadDataStatus.success,
        data: data,
      ));
    } catch (_) {
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

}
