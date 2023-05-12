import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/commons/index.dart';

part 'select_options_event.dart';
part 'select_options_state.dart';


class SelectOptionsBloc extends Bloc<SelectOptionsEvent, SelectOptionsState> {

  SelectOptionsBloc() : super(const SelectOptionsState()) {
    on<SelectOptionsInitial>(_onInitial);
    on<SelectOptionsReloaded>(_onReloaded);
  }

  void _onInitial(event, emit) async {
    emit(state.copyWith(
      map: {
        ...state.map,
        event.prefix: SelectOptionsModel(query: event.query),
      }
    ));
    add(SelectOptionsReloaded(prefix: event.prefix));
  }

  void _onReloaded(event, emit) async {
    try {
      Map<String, SelectOptionsModel> newMap = {...state.map};
      newMap[event.prefix] = newMap[event.prefix]!.copyWith(
        status: LoadDataStatus.progress
      );
      emit(state.copyWith(map: newMap));

      final items = await BaseRepository.queryAll(event.prefix, state.map[event.prefix]!.query ?? { });

      Map<String, SelectOptionsModel> newMap2 = {...state.map};
      newMap2[event.prefix] = newMap2[event.prefix]!.copyWith(
        status: LoadDataStatus.success,
        options: items,
      );
      emit(state.copyWith(map: newMap2));

    } catch (_) {
      Map<String, SelectOptionsModel> newMap = {...state.map};
      newMap[event.prefix] = newMap[event.prefix]!.copyWith(
          status: LoadDataStatus.failure
      );
      emit(state.copyWith(map: newMap));
    }
  }

}
