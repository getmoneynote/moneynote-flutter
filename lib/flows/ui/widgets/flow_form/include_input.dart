import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/flows/index.dart';

class IncludeInput extends StatelessWidget {

  const IncludeInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FlowFormBloc, FlowFormState, bool?>(
      selector: (state) => state.form['include'],
      builder: (context, state) {
        return MyFormSwitch(
          label: '是否统计',
          value: state,
          onChange: (value) => context.read<FlowFormBloc>().add(FieldChanged({ 'include': value })),
        );
      }
    );
  }

}


