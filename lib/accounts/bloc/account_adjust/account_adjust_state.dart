part of 'account_adjust_bloc.dart';

class AccountAdjustState extends Equatable {

  final bool valid;
  final FormzSubmissionStatus submissionStatus;
  final Map<String, dynamic> form;
  final NotEmptyNumFormz balance;
  final int action;
  final Map<String, dynamic> currentRow;

  const AccountAdjustState({
    this.valid = true,
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.form = const { },
    this.balance = const NotEmptyNumFormz.pure(),
    this.action = 1,
    this.currentRow = const { }
  });

  AccountAdjustState copyWith({
    bool? valid,
    FormzSubmissionStatus? submissionStatus,
    Map<String, dynamic>? form,
    NotEmptyNumFormz? balance,
    int? action,
    Map<String, dynamic>? currentRow
  }) {
    return AccountAdjustState(
      valid: valid ?? this.valid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      form: form ?? this.form,
      balance: balance ?? this.balance,
      action: action ?? this.action,
      currentRow: currentRow ?? this.currentRow,
    );
  }

  @override
  List<Object> get props => [valid, submissionStatus, form, balance, action, currentRow];

}
