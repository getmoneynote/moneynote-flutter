import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/index.dart';
import '/flows/index.dart';

class CreateTimeInput extends StatelessWidget {

  const CreateTimeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FlowFormBloc, FlowFormState, int?>(
      selector: (state) => state.form['createTime'],
      builder: (context, state) {
        return MyFormDate(
          label: '时间',
          value: state,
          required: true,
          onChange: (value) => context.read<FlowFormBloc>().add(FieldChanged({ 'createTime': value })),
        );
      }
    );
  }
}