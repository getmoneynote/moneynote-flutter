import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '/commons/index.dart';

part 'flow_form_event.dart';
part 'flow_form_state.dart';

class FlowFormBloc extends Bloc<FlowFormEvent, FlowFormState> {

  FlowFormBloc() : super(const FlowFormState()) {
    on<FieldChanged>(_onFieldChanged);
    on<AccountChanged>(_onAccountChanged);
    on<ToAccountChanged>(_onToAccountChanged);
    on<CategoryChanged>(_onCategoryChanged);
    on<CategoryAmountChanged>(_onCategoryAmountChanged);
    on<CategoryConvertedAmountChanged>(_onCategoryConvertedAmountChanged);
    on<TabIndexChanged>(_onTabIndexChanged);
    on<CurrentBookChanged>(_onCurrentBookChanged);
    on<DefaultLoaded>(_onDefaultLoaded);
    on<Submitted>(_onSubmitted);
  }

  bool _checkValid() {
    if (state.tabIndex != 2) {
      if (state.form['categories']?.isEmpty ?? true) {
        return false;
      }
      for (var categoryAmount in state.categoryAmount) {
        if (!validAmount(categoryAmount['amount'])) {
          return false;
        }
        if (state.needConvert) {
          if (!validAmount(categoryAmount['convertedAmount'])) {
            return false;
          }
        }
      }
    } else {
      if (state.form['accountId'] == null) {
        return false;
      }

      if (!validAmount(state.form['amount'])) {
        return false;
      }
    }
    return true;
  }

  void _onFieldChanged(event, emit) {
    emit(state.copyWith(
      form: { ...state.form, ...event.field },
    ));
    emit(state.copyWith(
      valid: _checkValid(),
    ));
  }

  void _onCurrentBookChanged(event, emit) {
    emit(state.copyWith(
      currentBook: event.currentBook,
      form: { ...state.form, ...{ 'bookId': event.currentBook['id'] } }
    ));
  }

  void _onAccountChanged(event, emit) {
    emit(state.copyWith(
      account: event.value,
      form: {...state.form, 'accountId': event.value?['id'] ?? ''},
    ));
    emit(state.copyWith(
      valid: _checkValid(),
    ));
  }

  void _onToAccountChanged(event, emit) {
    emit(state.copyWith(
      toAccount: event.value,
      form: {...state.form, 'toId': event.value['id']},
    ));
    emit(state.copyWith(
      valid: _checkValid(),
    ));
  }

  void _onCategoryChanged(event, emit) {
    emit(state.copyWith(
      form: {
        ...state.form,
        'categories': event.categories
      },
      categoryAmount: List<Map<String, dynamic>>.from(event.categories.map((e) {
        // 先要查找之前有没有，避免每次更新分类都将之前的金额清空了。
        return state.categoryAmount.firstWhere((e1) => e1['categoryId'] == e['id'], orElse: () {
          return {
            'categoryId': e['id'],
            'categoryName': e['name'],
            'amount': '',
            'convertedAmount': '',
          };
        });
      }))
    ));
    emit(state.copyWith(
      valid: _checkValid(),
    ));
  }

  void _onCategoryAmountChanged(event, emit) {
    var newCategoryAmount = [...state.categoryAmount];
    var target = newCategoryAmount.firstWhere((e) => e['categoryId'] == event.categoryId);
    target['amount'] = event.amount;
    emit(state.copyWith(
      categoryAmount: newCategoryAmount
    ));
    emit(state.copyWith(
      valid: _checkValid(),
    ));
  }

  void _onCategoryConvertedAmountChanged(event, emit) {
    var newCategoryAmount = [...state.categoryAmount];
    var target = newCategoryAmount.firstWhere((e) => e['categoryId'] == event.categoryId);
    target['convertedAmount'] = event.convertedAmount;
    emit(state.copyWith(
        categoryAmount: newCategoryAmount
    ));
    emit(state.copyWith(
      valid: _checkValid(),
    ));
  }

  void _onTabIndexChanged(event, emit) {
    emit(state.copyWith(
      tabIndex: event.tabIndex
    ));
  }

  void _onDefaultLoaded(event, emit) {
    // 默认为不是新增操作，拉取currentRow的数据。
    var initAccount = event.currentRow['account'];
    var initCategories = List<Map<String, dynamic>>.from(event.currentRow['categories']?.map((e) => e['category']) ?? [ ]);
    var initCategoryAmount = List<Map<String, dynamic>>.from(event.currentRow['categories']?.map((e) => {
      'categoryId': e['categoryId'],
      'categoryName': e['categoryName'],
      'amount': event.action == 4 ? '-${e['amount']}' : e['amount'],
      'convertedAmount': event.action == 4 ? '-${e['convertedAmount']}' : e['convertedAmount'],
    }) ?? [ ]);
    var initToAccount = event.currentRow['to'];
    // 新增的情况，加载账本的默认账户和分类。
    if (event.action == 1) {
      if (state.tabIndex == 0) {
        initAccount = state.currentBook['defaultExpenseAccount'];
        initCategories = state.currentBook['defaultExpenseCategory'] != null ? [state.currentBook['defaultExpenseCategory']] : [];
      }
      if (state.tabIndex == 1) {
        initAccount = state.currentBook['defaultIncomeAccount'];
        initCategories = state.currentBook['defaultIncomeCategory'] != null ? [state.currentBook['defaultIncomeCategory']] : [];
      }
      if (state.tabIndex == 0 || state.tabIndex == 1) {
        if (initCategories.isEmpty) {
          initCategoryAmount = [];
        } else {
          initCategoryAmount = [{
            'categoryId': initCategories[0]['id'],
            'categoryName': initCategories[0]['name'],
            'amount': '',
            'convertedAmount': '',
          }];
        }
      }
      if (state.tabIndex == 2) {
        initAccount = state.currentBook['defaultTransferFromAccount'];
        initToAccount = state.currentBook['defaultTransferToAccount'];
      }
    }
    emit(state.copyWith(
      valid: event.action != 1,
      submissionStatus: FormzSubmissionStatus.initial,
      form: {
        ...event.currentRow, // title, createTime
        'bookId': state.currentBook['id'], // form page initState 里面bookId已确定
        if (event.action != 2) 'createTime': DateTime.now().millisecondsSinceEpoch,
        'accountId': initAccount?['id'],
        'toId': initToAccount?['id'],
        'payeeId': event.currentRow['payee']?['id'],
        'categories': initCategories,
        'tags': List<Map<String, dynamic>>.from(event.currentRow['tags']?.map((e) => e['tag']) ?? [ ]),
        if (event.action != 2) 'confirm': true,
        if (event.action == 1 || event.action == 3) 'include': true, // 新增和复制是include都为true，
        'updateBalance': true,
        if (event.action == 3) 'notes': null, //复制时notes为空
      },
      action: event.action,
      currentRow: event.currentRow,
      categoryAmount: initCategoryAmount,
      account: initAccount,
      toAccount: initToAccount
    ));
  }

  void _onSubmitted(event, emit) async {
    if (state.valid) {
      try {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
        bool result = false;
        if (state.action == 2) {
          result = await BaseRepository.update('balance-flows', state.currentRow['id'], {
            ...state.form,
            'tags': List<int>.from(state.form['tags']?.map((e) => e['id']) ?? [ ]),
            'categories': state.categoryAmount,
          });
        } else {
          result = await BaseRepository.add('balance-flows', {
            ...state.form,
            'type': flowTabIndexToType(state.tabIndex),
            'tags': List<int>.from(state.form['tags']?.map((e) => e['id']) ?? [ ]),
            'categories': state.categoryAmount,
          });
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
