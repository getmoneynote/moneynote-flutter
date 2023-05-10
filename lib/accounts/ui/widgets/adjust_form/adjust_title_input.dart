import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/accounts/index.dart';

class AdjustTitleInput extends StatelessWidget {

  const AdjustTitleInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AccountAdjustBloc, AccountAdjustState, String?>(
      selector: (state) => state.form['title'],
      builder: (context, state) {
        return MyFormText(
          label: '标题',
          value: state,
          onChange: (value) => context.read<AccountAdjustBloc>().add(AdjustFieldChanged({ 'title': value })),
        );
      }
    );
  }

}


