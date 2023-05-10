import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/accounts/index.dart';

class CreditLimitInput extends StatelessWidget {

  const CreditLimitInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AccountFormBloc, AccountFormState, String?>(
      selector: (state) => state.form['creditLimit'],
      builder: (context, state) {
        return MyFormText(
          label: '额度',
          value: state,
          onChange: (value) => context.read<AccountFormBloc>().add(FieldChanged({ 'creditLimit': value })),
        );
      }
    );
  }

}


