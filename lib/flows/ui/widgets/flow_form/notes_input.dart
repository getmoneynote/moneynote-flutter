import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/flows/index.dart';

class NotesInput extends StatelessWidget {

  const NotesInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FlowFormBloc, FlowFormState, String?>(
      selector: (state) => state.form['notes'],
      builder: (context, state) {
        return MyFormText(
          label: '备注',
          value: state,
          onChange: (value) => context.read<FlowFormBloc>().add(FieldChanged({ 'notes': value })),
        );
      }
    );
  }

}


