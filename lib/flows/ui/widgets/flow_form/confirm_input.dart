import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/flows/index.dart';

class ConfirmInput extends StatelessWidget {

  final int action;

  const ConfirmInput({
    super.key,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FlowFormBloc, FlowFormState, bool?>(
      selector: (state) => state.form['confirm'],
      builder: (context, state) {
        return MyFormSwitch(
          label: '是否确认',
          value: state,
          readOnly: action == 2,
          onChange: (value) => context.read<FlowFormBloc>().add(FieldChanged({ 'confirm': value })),
        );
      }
    );
  }

}


