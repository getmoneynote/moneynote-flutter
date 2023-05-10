part of 'account_form_bloc.dart';

class AccountFormState extends Equatable {

  final bool valid;
  final FormzSubmissionStatus submissionStatus;
  final Map<String, dynamic> form;
  final NotEmptyFormz nameFormz;
  final NotEmptyNumFormz balanceFormz;
  final int action;
  final String type;
  final Map<String, dynamic> currentRow;

  const AccountFormState({
    this.valid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.form = const { },
    this.nameFormz = const NotEmptyFormz.pure(),
    this.balanceFormz = const NotEmptyNumFormz.pure(),
    this.action = 1,
    this.type = 'CHECKING',
    this.currentRow = const { },
  });

  AccountFormState copyWith({
    bool? valid,
    FormzSubmissionStatus? submissionStatus,
    Map<String, dynamic>? form,
    NotEmptyFormz? nameFormz,
    NotEmptyNumFormz? balanceFormz,
    int? action,
    String? type,
    Map<String, dynamic>? currentRow
  }) {
    return AccountFormState(
      valid: valid ?? this.valid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      form: form ?? this.form,
      nameFormz: nameFormz ?? this.nameFormz,
      balanceFormz: balanceFormz ?? this.balanceFormz,
      action: action ?? this.action,
      type: type ?? this.type,
      currentRow: currentRow ?? this.currentRow,
    );
  }

  @override
  List<Object> get props => [valid, submissionStatus, form, nameFormz, balanceFormz, action, type, currentRow];

}
