import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/index.dart';
import '/login/index.dart';
import 'index.dart';

class StartPage extends StatelessWidget {

  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthBloc, AuthState, AuthStatus>(
        selector: (state) => state.status,
        builder: (context, state) {
          switch (state) {
            case AuthStatus.uninitialized:
              return const LoadingPage();
            case AuthStatus.loading:
              return const LoadingPage();
            case AuthStatus.unauthenticated:
              return const LoginPage();
            case AuthStatus.authenticated:
              return const IndexPage();
          }
        }
    );
  }
}
