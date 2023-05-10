import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/flows/index.dart';

class TitleInput extends StatelessWidget {

  const TitleInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FlowFormBloc, FlowFormState, String?>(
      selector: (state) => state.form['title'],
      builder: (context, state) {
        return MyFormText(
          label: '标题',
          value: state,
          onChange: (value) => context.read<FlowFormBloc>().add(FieldChanged({ 'title': value })),
        );
      }
    );
  }

}


