part of 'list_page_bloc.dart';

abstract class ListPageEvent extends Equatable {
  const ListPageEvent();
  @override
  List<Object?> get props => [];
}

class ListPageInitial extends ListPageEvent {
  const ListPageInitial({
    required this.prefix,
    this.query
  });
  final String prefix;
  final Map<String, dynamic>? query;
  @override
  List<Object?> get props => [prefix, query];
}

class ListPageReloaded extends ListPageEvent { }

class ListPageLoadMore extends ListPageEvent { }

class ListPageQueryChanged extends ListPageEvent {
  const ListPageQueryChanged(this.query);
  final Map<String, dynamic> query;
  @override
  List<Object> get props => [query];
}

class ListPageSortQueryChanged extends ListPageEvent {
  const ListPageSortQueryChanged(this.query);
  final Map<String, dynamic> query;
  @override
  List<Object> get props => [query];
}

class ListPageQueryReset extends ListPageEvent {
  const ListPageQueryReset(this.query);
  final Map<String, dynamic> query;
  @override
  List<Object> get props => [query];
}