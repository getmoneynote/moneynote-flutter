part of 'detail_page_bloc.dart';

abstract class DetailPageEvent extends Equatable {
  const DetailPageEvent();
  @override
  List<Object?> get props => [];
}

class DetailPageInitial extends DetailPageEvent {
  const DetailPageInitial({
    required this.prefix,
    required this.id,
  });
  final String prefix;
  final int id;
  @override
  List<Object> get props => [prefix, id];
}

class DetailPageReloaded extends DetailPageEvent { }

class DetailPageDeleted extends DetailPageEvent { }

class DetailPageToggled extends DetailPageEvent { }

class FlowDetailPageDeletedWithAccount extends DetailPageEvent { }
