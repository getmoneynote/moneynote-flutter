import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';
import '/components/index.dart';
import '/accounts/index.dart';

class BalanceInput extends StatelessWidget {

  final int action;

  const BalanceInput({
    super.key,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AccountFormBloc, AccountFormState, NotEmptyNumFormz>(
      selector: (state) => state.balanceFormz,
      builder: (context, state) {
        return MyFormText(
          label: '当前余额',
          value: state.value,
          onChange: (value) => context.read<AccountFormBloc>().add(BalanceChanged(value)),
          required: true,
          readOnly: action == 2,
          errorText: (state.isPure || state.isValid)? null : state.displayError == NotEmptyNumError.empty ? '请输入当前余额' : '格式错误',
        );
      }
    );
  }

}


