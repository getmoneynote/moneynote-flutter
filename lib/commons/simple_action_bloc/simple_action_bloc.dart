import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';

part 'simple_action_event.dart';
part 'simple_action_state.dart';


class SimpleActionBloc extends Bloc<SimpleActionEvent, SimpleActionState> {

  SimpleActionBloc() : super(const SimpleActionState()) {
    on<SimpleActionReloaded>(_onReloaded);
  }

  void _onReloaded(event, emit) async {
    try {
      emit(state.copyWith(
        status: LoadDataStatus.progress,
      ));
      await BaseRepository.action(event.uri);
      emit(state.copyWith(
        status: LoadDataStatus.success,
      ));
    } catch (_) {
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

}
