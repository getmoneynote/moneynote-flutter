import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/flows/index.dart';

class TransferAmountInput extends StatelessWidget {

  const TransferAmountInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FlowFormBloc, FlowFormState, dynamic>(
      selector: (state) => state.form['amount'],
      builder: (context, state) {
        return MyFormText(
          required: true,
          label: '金额',
          value: state,
          onChange: (value) => context.read<FlowFormBloc>().add(FieldChanged({ 'amount': value })),
        );
      }
    );
  }

}


