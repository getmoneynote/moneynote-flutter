import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '/commons/index.dart';

part 'list_page_event.dart';
part 'list_page_state.dart';

class ListPageBloc extends Bloc<ListPageEvent, ListPageState> {

  ListPageBloc() : super(const ListPageState()) {
    on<ListPageInitial>(_onInitial);
    on<ListPageReloaded>(_onReloaded);
    on<ListPageLoadMore>(_onLoadMore);
    on<ListPageQueryChanged>(_onQueryChanged);
    on<ListPageSortQueryChanged>(_onSortQueryChanged);
    on<ListPageQueryReset>(_onQueryReset);
  }

  void _onInitial(ListPageInitial event, Emitter<ListPageState> emit) async {
    emit(state.copyWith(
      prefix: event.prefix,
      query: {...{sortParameter : ''}, ...?event.query},
      status: LoadDataStatus.initial,
      items: [],
      loadMoreStatus: LoadDataStatus.initial,
    ));
    add(ListPageReloaded());
  }

  void _onReloaded(_, Emitter<ListPageState> emit) async {
    try {
      emit(state.copyWith(
        status: LoadDataStatus.progress,
        query: {...state.query, pageParameter: 1, pageSizeParameter: defaultPageSize},
      ));
      final items = await BaseRepository.query(state.prefix, {
        ...state.query,
        // 这里有待进一步抽象
        'categories': List<int>.from(state.query['categories']?.map((e) => e['value']) ?? [ ]),
        'tags': List<int>.from(state.query['tags']?.map((e) => e['value']) ?? [ ]),
      });
      if (items.length < defaultPageSize) {
        emit(state.copyWith(
          loadMoreStatus: LoadDataStatus.empty,
        ));
      }
      if (items.isNotEmpty) {
        emit(state.copyWith(
          status: LoadDataStatus.success,
          items: items,
        ));
      } else {
        emit(state.copyWith(
          status: LoadDataStatus.empty,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

  void _onLoadMore(_, Emitter<ListPageState> emit) async {
    try {
      emit(state.copyWith(
        loadMoreStatus: LoadDataStatus.progress,
        query: {...state.query, pageParameter: state.query[pageParameter] + 1},
      ));
      final items = await BaseRepository.query(state.prefix, {
        ...state.query,
        // 这里有待进一步抽象
        'categories': List<int>.from(state.query['categories']?.map((e) => e['value']) ?? [ ]),
        'tags': List<int>.from(state.query['tags']?.map((e) => e['value']) ?? [ ]),
      });
      if (items.isNotEmpty) {
        emit(state.copyWith(
          loadMoreStatus: LoadDataStatus.success,
          items: List.of(state.items)..addAll(items),
        ));
      } else {
        emit(state.copyWith(loadMoreStatus: LoadDataStatus.empty));
      }
    } catch (_) {
      emit(state.copyWith(loadMoreStatus: LoadDataStatus.failure));
    }
  }

  void _onQueryChanged(ListPageQueryChanged event, Emitter<ListPageState> emit) async {
    emit(state.copyWith(
      query: {...state.query, ...event.query},
    ));
    // add(ListPageReloaded());
  }

  void _onSortQueryChanged(ListPageSortQueryChanged event, Emitter<ListPageState> emit) async {
    emit(state.copyWith(
      query: {...state.query, ...event.query},
    ));
    add(ListPageReloaded());
  }

  void _onQueryReset(ListPageQueryReset event, Emitter<ListPageState> emit) async {
    emit(state.copyWith(
      query: {sortParameter : '', ...event.query},
    ));
    // add(ListPageReloaded());
  }

}
