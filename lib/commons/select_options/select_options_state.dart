part of 'select_options_bloc.dart';

class SelectOptionsState extends Equatable {

  final Map<String, SelectOptionsModel> map;

  const SelectOptionsState({
    this.map = const { },
  });

  SelectOptionsState copyWith({
    Map<String, SelectOptionsModel>? map,
  }) {
    return SelectOptionsState(
      map: map ?? this.map,
    );
  }

  @override
  List<Object> get props => [map];

}

class SelectOptionsModel extends Equatable {

  const SelectOptionsModel({
    this.query,
    this.status = LoadDataStatus.initial,
    this.options = const [],
  });

  final Map<String, dynamic>? query;
  final LoadDataStatus status;
  final List<Map<String, dynamic>> options;

  SelectOptionsModel copyWith({
    Map<String, dynamic>? query,
    LoadDataStatus? status,
    List<Map<String, dynamic>>? options,
  }) {
    return SelectOptionsModel(
      query: query ?? this.query,
      status : status ?? this.status,
      options : options ?? this.options,
    );
  }

  @override
  List<Object?> get props => [query, status, options];

}