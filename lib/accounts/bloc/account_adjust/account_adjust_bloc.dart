import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '/commons/index.dart';
import '/accounts/index.dart';

part 'account_adjust_event.dart';
part 'account_adjust_state.dart';

class AccountAdjustBloc extends Bloc<AccountAdjustEvent, AccountAdjustState> {

  AccountAdjustBloc() : super(const AccountAdjustState()) {
    on<AdjustFieldChanged>(_onFieldChanged);
    on<AdjustBalanceChanged>(_onBalanceChanged);
    on<AdjustDefaultLoaded>(_onDefaultLoaded);
    on<AdjustSubmitted>(_onSubmitted);
  }

  void _onFieldChanged(AdjustFieldChanged event, Emitter<AccountAdjustState> emit) {
    emit(state.copyWith(
      form: { ...state.form, ...event.field },
    ));
  }

  void _onBalanceChanged(AdjustBalanceChanged event, Emitter<AccountAdjustState> emit) {
    final balance = NotEmptyNumFormz.dirty(value: event.value);
    emit(state.copyWith(
      balance: balance,
      valid: Formz.validate([balance]),
      form: {...state.form, 'balance': event.value},
    ));
  }

  void _onDefaultLoaded(AdjustDefaultLoaded event, Emitter<AccountAdjustState> emit) {
    emit(state.copyWith(
      valid: true,
      submissionStatus: FormzSubmissionStatus.initial,
      form: {
        ...event.currentRow,
        // 新增时，currentrow是account，有可能读到错误的title 和notes。
        if (event.action == 2) 'bookId': event.currentRow['book']['id'],
        'title': event.action == 1 ? '' : event.currentRow['title'],
        'createTime': event.action == 1 ? DateTime.now().millisecondsSinceEpoch : event.currentRow['createTime'],
        // 'balance': event.currentRow['balance'],
        'notes': event.action == 1 ? '' : event.currentRow['notes'],
      },
      balance: event.currentRow['balance'] != null ? NotEmptyNumFormz.dirty(value: removeDecimalZero(event.currentRow['balance'])) : const NotEmptyNumFormz.pure(),
      action: event.action,
      currentRow: event.currentRow,
    ));
  }

  void _onSubmitted(AdjustSubmitted event, Emitter<AccountAdjustState> emit) async {
    if (state.valid) {
      try {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
        bool result = false;
        switch (state.action) {
          case 1:
            result = await AccountRepository.createAdjust(state.currentRow['id'], state.form);
            break;
          case 2:
            result = await AccountRepository.updateAdjust(state.currentRow['id'], state.form);
            break;
        }
        if (result) {
          emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
        } else {
          emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
        }
      } catch (_) {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
      }
    }
  }

}
