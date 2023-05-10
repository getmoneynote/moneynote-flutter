import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/accounts/index.dart';

class CanTransferFromInput extends StatelessWidget {

  const CanTransferFromInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AccountFormBloc, AccountFormState, bool?>(
      selector: (state) => state.form['canTransferFrom'],
      builder: (context, state) {
        return MyFormSwitch(
          label: '是否可转出',
          value: state,
          onChange: (value) => context.read<AccountFormBloc>().add(FieldChanged({ 'canTransferFrom': value })),
        );
      }
    );
  }

}


