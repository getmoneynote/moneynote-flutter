part of 'detail_page_bloc.dart';

class DetailPageState extends Equatable {

  final String prefix;
  final int id;
  final LoadDataStatus status;
  final Map<String, dynamic> item;
  final LoadDataStatus deleteStatus;
  final LoadDataStatus toggleStatus;

  const DetailPageState({
    this.prefix = '',
    this.id = 0,
    this.status = LoadDataStatus.initial,
    this.item = const { },
    this.deleteStatus = LoadDataStatus.initial,
    this.toggleStatus = LoadDataStatus.initial,
  });

  DetailPageState copyWith({
    String? prefix,
    int? id,
    LoadDataStatus? status,
    Map<String, dynamic>? item,
    LoadDataStatus? deleteStatus,
    LoadDataStatus? toggleStatus,
  }) {
    return DetailPageState(
      prefix: prefix ?? this.prefix,
      id: id ?? this.id,
      status: status ?? this.status,
      item: item ?? this.item,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      toggleStatus: toggleStatus ?? this.toggleStatus
    );
  }

  @override
  List<Object?> get props => [prefix, id, status, item, deleteStatus, toggleStatus];

}

