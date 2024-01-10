part of 'flow_image_bloc.dart';

abstract class FlowImageEvent extends Equatable {
  const FlowImageEvent();
  @override
  List<Object> get props => [];
}

class FlowImageReloaded extends FlowImageEvent {
  final int id;
  const FlowImageReloaded(this.id);
  @override
  List<Object> get props => [id];
}

class FlowImageDeleted extends FlowImageEvent {
  final int id;
  const FlowImageDeleted(this.id);
  @override
  List<Object> get props => [id];
}

class FlowImageUploaded extends FlowImageEvent {
  final int id;
  final String filePath;
  const FlowImageUploaded(this.id, this.filePath);
  @override
  List<Object> get props => [id, filePath];
}

