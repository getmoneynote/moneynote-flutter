part of 'flow_form_bloc.dart';

class FlowFormState extends Equatable {

  final bool valid;
  final FormzSubmissionStatus submissionStatus;
  final Map<String, dynamic> form;
  final int action;
  final int tabIndex;
  final Map<String, dynamic> currentRow;
  final Map<String, dynamic> currentBook;
  final List<Map<String, dynamic>> categoryAmount;
  final Map<String, dynamic>? account;
  final Map<String, dynamic>? toAccount;

  const FlowFormState({
    this.valid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.form = const { },
    this.action = 1,
    this.tabIndex = 0,
    this.currentRow = const { },
    this.currentBook = const { },
    this.categoryAmount = const [ ],
    this.account,
    this.toAccount,
  });

  FlowFormState copyWith({
    bool? valid,
    FormzSubmissionStatus? submissionStatus,
    Map<String, dynamic>? form,
    int? action,
    int? tabIndex,
    Map<String, dynamic>? currentRow,
    Map<String, dynamic>? currentBook,
    List<Map<String, dynamic>>? categoryAmount,
    Map<String, dynamic>? account,
    Map<String, dynamic>? toAccount,
  }) {
    return FlowFormState(
      valid: valid ?? this.valid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      form: form ?? this.form,
      action: action ?? this.action,
      tabIndex: tabIndex ?? this.tabIndex,
      currentRow: currentRow ?? this.currentRow,
      currentBook: currentBook ?? this.currentBook,
      categoryAmount: categoryAmount ?? this.categoryAmount,
      account: account ?? this.account,
      toAccount: toAccount ?? this.toAccount,
    );
  }

  @override
  List<Object?> get props => [
    valid,
    submissionStatus,
    form,
    action,
    tabIndex,
    currentRow,
    currentBook,
    categoryAmount,
    account,
    toAccount,
  ];

  bool get needConvert {
    if (account == null || account!['currencyCode'] == null) return false;
    if (tabIndex == 0 || tabIndex == 1) {
      return account!['currencyCode'] != currentBook['defaultCurrencyCode'];
    } else if (tabIndex == 2) {
      if (toAccount == null || toAccount!['currencyCode'] == null) return false;
      return account!['currencyCode'] != toAccount!['currencyCode'];
    }
    return false;
  }

  String get convertCode {
    if (tabIndex == 2) {
      return toAccount?['currencyCode'];
    } else {
      return currentBook['defaultCurrencyCode'];
    }
  }

}
