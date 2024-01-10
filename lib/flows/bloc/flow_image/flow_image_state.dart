part of 'flow_image_bloc.dart';

class FlowImageState extends Equatable {

  final LoadDataStatus status;
  final List<Map<String, dynamic>> items;
  final LoadDataStatus deleteStatus;
  final LoadDataStatus uploadStatus;

  const FlowImageState({
    this.status = LoadDataStatus.initial,
    this.deleteStatus = LoadDataStatus.initial,
    this.uploadStatus = LoadDataStatus.initial,
    this.items = const [],
  });

  FlowImageState copyWith({
    LoadDataStatus? status,
    LoadDataStatus? deleteStatus,
    LoadDataStatus? uploadStatus,
    List<Map<String, dynamic>>? items,
  }) {
    return FlowImageState(
      status: status ?? this.status,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [status, items, deleteStatus, uploadStatus];

}