import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/flows/index.dart';

class TransferAmountInput extends StatelessWidget {

  const TransferAmountInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlowFormBloc, FlowFormState>(
      buildWhen: (previous, current) => previous.needConvert != current.needConvert,
      builder: (context, state) {
        return Column(
          children: [
            MyFormText(
              required: true,
              label: '金额',
              value: state.form['amount'],
              onChange: (value) => context.read<FlowFormBloc>().add(FieldChanged({ 'amount': value })),
            ),
            if (state.needConvert) MyFormText(
              required: true,
              label: "折合${state.convertCode}",
              value: state.form['convertedAmount'],
              onChange: (value) => context.read<FlowFormBloc>().add(FieldChanged({ 'convertedAmount': value })),
            ),
          ],
        );
      }
    );
  }

}


