import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/accounts/index.dart';

class AdjustNotesInput extends StatelessWidget {

  const AdjustNotesInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AccountAdjustBloc, AccountAdjustState, String?>(
      selector: (state) => state.form['notes'],
      builder: (context, state) {
        return MyFormText(
          label: '备注',
          value: state,
          onChange: (value) => context.read<AccountAdjustBloc>().add(AdjustFieldChanged({ 'notes': value })),
        );
      }
    );
  }

}


