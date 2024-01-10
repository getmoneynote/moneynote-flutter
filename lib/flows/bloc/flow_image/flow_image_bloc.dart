import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/utils.dart';
import '../../../commons/base_repository.dart';
import '../../data/flow_repository.dart';

part 'flow_image_event.dart';
part 'flow_image_state.dart';

class FlowImageBloc extends Bloc<FlowImageEvent, FlowImageState> {

  FlowImageBloc() : super(const FlowImageState()) {
    on<FlowImageReloaded>(_onReloaded);
    on<FlowImageDeleted>(_onDeleted);
    on<FlowImageUploaded>(_onUploaded);
  }

  void _onReloaded(event, emit) async {
    try {
      emit(state.copyWith(
        status: LoadDataStatus.progress,
      ));
      final items = await FlowRepository.getFiles(event.id);
      emit(state.copyWith(
        status: LoadDataStatus.success,
        items: items,
      ));
    } catch (_) {
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

  void _onDeleted(event, emit) async {
    try {
      emit(state.copyWith(deleteStatus: LoadDataStatus.progress));
      final result = await BaseRepository.delete('flow-files', event.id);
      if (result) {
        emit(state.copyWith(deleteStatus: LoadDataStatus.success));
      } else {
        emit(state.copyWith(deleteStatus: LoadDataStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(deleteStatus: LoadDataStatus.failure));
    }
  }

  void _onUploaded(event, emit) async {
    try {
      emit(state.copyWith(uploadStatus: LoadDataStatus.progress));
      final result = await FlowRepository.uploadFile(event.id, event.filePath);
      if (result) {
        emit(state.copyWith(uploadStatus: LoadDataStatus.success));
      } else {
        emit(state.copyWith(uploadStatus: LoadDataStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(uploadStatus: LoadDataStatus.failure));
    }
  }

}
