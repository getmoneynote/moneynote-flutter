import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/accounts/index.dart';

class CanTransferToInput extends StatelessWidget {

  const CanTransferToInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AccountFormBloc, AccountFormState, bool?>(
      selector: (state) => state.form['canTransferTo'],
      builder: (context, state) {
        return MyFormSwitch(
          label: '是否可转入',
          value: state,
          onChange: (value) => context.read<AccountFormBloc>().add(FieldChanged({ 'canTransferTo': value })),
        );
      }
    );
  }

}


