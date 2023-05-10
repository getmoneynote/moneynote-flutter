import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';
import '/components/index.dart';
import '/accounts/index.dart';

class AdjustBalanceInput extends StatelessWidget {

  const AdjustBalanceInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AccountAdjustBloc, AccountAdjustState, NotEmptyNumFormz>(
      selector: (state) => state.balance,
      builder: (context, state) {
        return MyFormText(
          label: '更新余额',
          value: state.value,
          onChange: (value) => context.read<AccountAdjustBloc>().add(AdjustBalanceChanged(value)),
          required: true,
          errorText: (state.isPure || state.isValid)? null : state.displayError == NotEmptyNumError.empty ? '请输入余额' : '格式错误',
        );
      }
    );
  }

}


