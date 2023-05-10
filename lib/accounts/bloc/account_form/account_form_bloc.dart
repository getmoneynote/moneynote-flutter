import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '/commons/index.dart';

part 'account_form_event.dart';
part 'account_form_state.dart';

class AccountFormBloc extends Bloc<AccountFormEvent, AccountFormState> {

  AccountFormBloc() : super(const AccountFormState()) {
    on<FieldChanged>(_onFieldChanged);
    on<NameChanged>(_onNameChanged);
    on<BalanceChanged>(_onBalanceChanged);
    on<DefaultLoaded>(_onDefaultLoaded);
    on<Submitted>(_onSubmitted);
  }

  void _onFieldChanged(FieldChanged event, Emitter<AccountFormState> emit) {
    emit(state.copyWith(
      form: { ...state.form, ...event.field },
    ));
  }

  void _onNameChanged(NameChanged event, Emitter<AccountFormState> emit) {
    final name = NotEmptyFormz.dirty(value: event.name);
    emit(state.copyWith(
      nameFormz: name,
      valid: Formz.validate([name, state.balanceFormz]),
      form: {...state.form, 'name': event.name},
    ));
  }

  void _onBalanceChanged(BalanceChanged event, Emitter<AccountFormState> emit) {
    final balance = NotEmptyNumFormz.dirty(value: event.balance);
    emit(state.copyWith(
      balanceFormz: balance,
      valid: Formz.validate([balance, state.nameFormz]),
      form: {...state.form, 'balance': event.balance},
    ));
  }

  void _onDefaultLoaded(DefaultLoaded event, Emitter<AccountFormState> emit) {
    // emit(state.copyWith(
    //   valid: event.action != 1,
    //   submissionStatus: FormzSubmissionStatus.initial,
    //   form: {
    //     'currencyCode': event.currentRow['currencyCode'],
    //     'name': event.currentRow['name'],
    //     'no': event.currentRow['no'],
    //     'canExpense': event.currentRow['canExpense'] ?? (event.type == 'CHECKING' || event.type == 'CREDIT') ? true : false,
    //     'canIncome': event.currentRow['canIncome'] ?? event.type == 'CHECKING' ? true : false,
    //     'canTransferFrom': event.currentRow['canTransferFrom'] ?? event.type != 'CREDIT' ? true : false,
    //     'canTransferTo': event.currentRow['canTransferTo'] ?? true,
    //     'include': event.currentRow['include'] ?? true,
    //     'notes': event.currentRow['notes'],
    //     'creditLimit': event.currentRow['creditLimit'],
    //     'billDay': event.currentRow['billDay'],
    //     'apr': event.currentRow['apr'],
    //   },
    //   name: event.currentRow['name'] != null ? NotEmptyFormz.dirty(value: event.currentRow['name']) : const NotEmptyFormz.pure(),
    //   balance: event.currentRow['balance'] != null ? NotEmptyNumFormz.dirty(value: event.currentRow['balance'].toString()) : const NotEmptyNumFormz.pure(),
    //   action: event.action,
    //   type: event.type,
    //   currentRow: event.currentRow,
    // ));
    emit(state.copyWith(
      valid: event.action != 1,
      submissionStatus: FormzSubmissionStatus.initial,
      form: {
        ...event.currentRow,
        'canExpense': event.currentRow['canExpense'] ?? (event.type == 'CHECKING' || event.type == 'CREDIT') ? true : false,
        'canIncome': event.currentRow['canIncome'] ?? event.type == 'CHECKING' ? true : false,
        'canTransferFrom': event.currentRow['canTransferFrom'] ?? event.type != 'CREDIT' ? true : false,
        'canTransferTo': true,
        'include': true,
      },
      nameFormz: event.currentRow['name'] != null ? NotEmptyFormz.dirty(value: event.currentRow['name']) : const NotEmptyFormz.pure(),
      balanceFormz: event.currentRow['balance'] != null ? NotEmptyNumFormz.dirty(value: removeDecimalZero(event.currentRow['balance'])) : const NotEmptyNumFormz.pure(),
      action: event.action,
      type: event.type,
      currentRow: event.currentRow,
    ));

  }

  void _onSubmitted(Submitted event, Emitter<AccountFormState> emit) async {
    if (state.valid) {
      try {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
        bool result = false;
        switch (state.action) {
          case 1:
            result = await BaseRepository.add('accounts', {
              ...state.form,
              'type': state.type
            });
            break;
          case 2:
            result = await BaseRepository.update('accounts', state.currentRow['id'], state.form);
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
