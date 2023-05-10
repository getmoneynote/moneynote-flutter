import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/accounts/index.dart';

class IncludeInput extends StatelessWidget {

  const IncludeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AccountFormBloc, AccountFormState, bool?>(
      selector: (state) => state.form['include'],
      builder: (context, state) {
        return MyFormSwitch(
          label: '是否计入净资产',
          value: state,
          onChange: (value) => context.read<AccountFormBloc>().add(FieldChanged({ 'include': value })),
        );
      }
    );
  }

}


