import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/accounts/index.dart';

class NoInput extends StatelessWidget {

  const NoInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AccountFormBloc, AccountFormState, String?>(
      selector: (state) => state.form['no'],
      builder: (context, state) {
        return MyFormText(
          label: '卡号',
          value: state,
          onChange: (value) => context.read<AccountFormBloc>().add(FieldChanged({ 'no': value })),
        );
      }
    );
  }

}


