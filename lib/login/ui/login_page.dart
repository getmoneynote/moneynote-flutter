import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/index.dart';
import '/login/index.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 50, bottom: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo.png', width: 50, height: 50),
                    const SizedBox(width: 20),
                    Text("九快记账", style: Theme.of(context).textTheme.titleLarge?.apply(fontWeightDelta: 2)),
                  ],
                )
              ),
              BlocProvider(
                create: (_) => LoginBloc(
                    authBloc: BlocProvider.of<AuthBloc>(context)
                ),
                child: const LoginForm(),
              ),
              const SizedBox(height: 20),
              Text("v1.0.23", style: Theme.of(context).textTheme.bodySmall)
            ],
          )
        ),
      )
    );
  }

}