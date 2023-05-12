import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/flows/index.dart';

class UpdateBalanceInput extends StatelessWidget {

  const UpdateBalanceInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FlowFormBloc, FlowFormState, bool?>(
      selector: (state) => state.form['updateBalance'],
      builder: (context, state) {
        return MyFormSwitch(
          label: '是否更新账户',
          value: state,
          onChange: (value) => context.read<FlowFormBloc>().add(FieldChanged({ 'updateBalance': value })),
        );
      }
    );
  }

}


