part of 'account_overview_bloc.dart';

class AccountOverviewState extends Equatable {

  final LoadDataStatus status;
  final List<num> data;

  const AccountOverviewState({
    this.status = LoadDataStatus.initial,
    this.data = const [ ],
  });

  AccountOverviewState copyWith({
    LoadDataStatus? status,
    List<num>? data,
  }) {
    return AccountOverviewState(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [status, data];

}