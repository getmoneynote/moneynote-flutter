import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';
import '/components/index.dart';
import '/accounts/index.dart';

class NameInput extends StatelessWidget {

  const NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AccountFormBloc, AccountFormState, NotEmptyFormz>(
      selector: (state) => state.nameFormz,
      builder: (context, state) {
        return MyFormText(
          label: '名称',
          value: state.value,
          onChange: (value) => context.read<AccountFormBloc>().add(NameChanged(value)),
          required: true,
          errorText: (state.isPure || state.isValid) ? null : '请输入账户名称' ,
        );
      }
    );
  }

}


