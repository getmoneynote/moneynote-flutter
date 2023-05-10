import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../base_repository.dart';
import '/commons/utils.dart';

part 'detail_page_event.dart';
part 'detail_page_state.dart';

class DetailPageBloc extends Bloc<DetailPageEvent, DetailPageState> {

  DetailPageBloc() : super(const DetailPageState()) {
    on<DetailPageInitial>(_onInitial);
    on<DetailPageReloaded>(_onReloaded);
    on<DetailPageDeleted>(_onDeleted);
    on<DetailPageToggled>(_onToggled);
  }

  void _onInitial(DetailPageInitial event, Emitter<DetailPageState> emit) async {
    emit(state.copyWith(
        prefix: event.prefix,
        id: event.id,
    ));
    add(DetailPageReloaded());
  }

  void _onReloaded(_, Emitter<DetailPageState> emit) async {
    try {
      emit(state.copyWith(
        status: LoadDataStatus.progress,
      ));
      final item = await BaseRepository.get(state.prefix, state.id);
      emit(state.copyWith(
        status: LoadDataStatus.success,
        item: item,
      ));
    } catch (_) {
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

  void _onDeleted(_, Emitter<DetailPageState> emit) async {
    try {
      emit(state.copyWith(deleteStatus: LoadDataStatus.progress));
      final result = await BaseRepository.delete(state.prefix, state.id);
      if (result) {
        emit(state.copyWith(deleteStatus: LoadDataStatus.success));
      } else {
        emit(state.copyWith(deleteStatus: LoadDataStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(deleteStatus: LoadDataStatus.failure));
    }
  }

  void _onToggled(_, Emitter<DetailPageState> emit) async {
    try {
      emit(state.copyWith(toggleStatus: LoadDataStatus.progress));
      final result = await BaseRepository.toggle(state.prefix, state.id);
      if (result) {
        emit(state.copyWith(toggleStatus: LoadDataStatus.success));
      } else {
        emit(state.copyWith(toggleStatus: LoadDataStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(toggleStatus: LoadDataStatus.failure));
    }
  }

}
