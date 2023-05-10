import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/accounts/index.dart';

class CanIncomeInput extends StatelessWidget {

  const CanIncomeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AccountFormBloc, AccountFormState, bool?>(
      selector: (state) => state.form['canIncome'],
      builder: (context, state) {
        return MyFormSwitch(
          label: '是否可收入',
          value: state,
          onChange: (value) => context.read<AccountFormBloc>().add(FieldChanged({ 'canIncome': value })),
        );
      }
    );
  }

}


