import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';
import '/login/index.dart';

class UsernameInput extends StatelessWidget {

  const UsernameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginState, NotEmptyFormz>(
      selector: (state) => state.usernameFormz,
      builder: (context, state) {
        return TextField(
          onChanged: (value) => context.read<LoginBloc>().add(UsernameChanged(value)),
          decoration: InputDecoration(
            hintText: '用户名',
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            errorText: (state.isPure || state.isValid) ? null : '请输入用户名' ,
          ),
        );
      },
    );
  }
}