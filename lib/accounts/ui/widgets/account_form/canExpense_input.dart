import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/accounts/index.dart';

class CanExpenseInput extends StatelessWidget {

  const CanExpenseInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AccountFormBloc, AccountFormState, bool?>(
      selector: (state) => state.form['canExpense'],
      builder: (context, state) {
        return MyFormSwitch(
          label: '是否可支出',
          value: state,
          onChange: (value) => context.read<AccountFormBloc>().add(FieldChanged({ 'canExpense': value })),
        );
      }
    );
  }

}


