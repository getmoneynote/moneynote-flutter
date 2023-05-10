import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/index.dart';
import '/accounts/index.dart';

class AdjustCreateTimeInput extends StatelessWidget {

  const AdjustCreateTimeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AccountAdjustBloc, AccountAdjustState, int?>(
      selector: (state) => state.form['createTime'],
      builder: (context, state) {
        return MyFormDate(
          label: '时间',
          value: state,
          required: true,
          onChange: (value) {
            BlocProvider.of<AccountAdjustBloc>(context).add(AdjustFieldChanged({ 'createTime': value }));
          },
        );
      }
    );
  }
}