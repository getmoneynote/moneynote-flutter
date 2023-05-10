import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/accounts/index.dart';

class AprInput extends StatelessWidget {

  const AprInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AccountFormBloc, AccountFormState, String?>(
      selector: (state) => state.form['apr'],
      builder: (context, state) {
        return MyFormText(
          label: '年化利率(%)',
          value: state,
          onChange: (value) => context.read<AccountFormBloc>().add(FieldChanged({ 'apr': value })),
        );
      }
    );
  }

}


