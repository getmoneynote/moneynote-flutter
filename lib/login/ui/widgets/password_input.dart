import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/commons/index.dart';
import '/login/index.dart';

class PasswordInput extends StatelessWidget {

  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginState, NotEmptyFormz>(
      selector: (state) => state.passwordFormz,
      builder: (context, state) {
        return TextField(
          onChanged: (password) => context.read<LoginBloc>().add(PasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            hintText: '密码',
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            errorText: (state.isPure || state.isValid) ? null : '请输入密码',
          ),
        );
      },
    );
  }

}