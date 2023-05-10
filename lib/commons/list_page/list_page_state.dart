part of 'list_page_bloc.dart';

class ListPageState extends Equatable {

  final String prefix;
  final LoadDataStatus status;
  final List<Map<String, dynamic>> items;
  final Map<String, dynamic> query;
  final LoadDataStatus loadMoreStatus;

  const ListPageState({
    this.prefix = '',
    this.status = LoadDataStatus.initial,
    this.items = const [],
    this.query = const { sortParameter : '' },
    this.loadMoreStatus = LoadDataStatus.initial,
  });

  ListPageState copyWith({
    String? prefix,
    LoadDataStatus? status,
    List<Map<String, dynamic>>? items,
    Map<String, dynamic>? query,
    LoadDataStatus? loadMoreStatus,
  }) {

    return ListPageState(
      prefix: prefix ?? this.prefix,
      status: status ?? this.status,
      items: items ?? this.items,
      query: query ?? this.query,
      loadMoreStatus: loadMoreStatus ?? this.loadMoreStatus,
    );
  }

  @override
  List<Object> get props => [prefix, status, items, query, loadMoreStatus];

}

