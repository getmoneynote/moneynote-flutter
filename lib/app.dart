import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/commons/index.dart';
import '/accounts/index.dart';
import '/flows/index.dart';
import '/login/index.dart';
import '/charts/index.dart';
import '/my/index.dart';
import 'routes.dart';

class App extends StatelessWidget {

  const App({super.key});

  dynamic initProviders1() {
    return [
      BlocProvider(
          create: (_) => AuthBloc()..add(AppStarted())
      ),
      BlocProvider(
          create: (_) => SelectOptionsBloc()
      ),
      BlocProvider(
          create: (_) => ListPageBloc()
      ),
      BlocProvider(
          create: (_) => DetailPageBloc()
      ),
      BlocProvider(
          create: (_) => SimpleActionBloc()
      ),
    ];
  }
  
  dynamic initProviders2() {
    return [
      BlocProvider(
          create: (context) => AccountFormBloc()
      ),
      BlocProvider(
          create: (context) => AccountAdjustBloc()
      ),
      BlocProvider(
          create: (context) => FlowFormBloc()
      ),
      BlocProvider(
          create: (context) => ChartBalanceBloc()..add(ChartBalanceReloaded())
      ),
      BlocProvider(
          create: (context) => ChartExpenseCategoryBloc()
      ),
      BlocProvider(
          create: (context) => ChartIncomeCategoryBloc()
      ),
      BlocProvider(
          create: (context) => AccountOverviewBloc()..add(AccountOverviewReloaded())
      ),
      BlocProvider(
          create: (context) => LanguageBloc()
      ),
      BlocProvider(
          create: (_) => FlowImageBloc()
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: initProviders1(),
      child: MultiBlocProvider(
        providers: initProviders2(),
        child: MaterialApp(
          title: '九快记账',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('zh'),
          routes: AppRouter.routes,
        ),
      )
    );
  }

}
