import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/accounts/index.dart';

class BillDayInput extends StatelessWidget {

  const BillDayInput({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AccountFormBloc, AccountFormState, String?>(
      selector: (state) => state.form['billDay'],
      builder: (context, state) {
        return MyFormText(
          label: type == 'CREDIT' ? '账单日' : '还款日',
          value: state,
          onChange: (value) => context.read<AccountFormBloc>().add(FieldChanged({ 'billDay': value })),
        );
      }
    );
  }

}


