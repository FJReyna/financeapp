import 'package:finance/core/dependency_injection.dart';
import 'package:finance/core/routes/app_router.dart';
import 'package:finance/core/theme/app_theme.dart';
import 'package:finance/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:finance/features/settings/presentation/bloc/settings_event.dart';
import 'package:finance/features/settings/presentation/bloc/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (context) => getIt<SettingsBloc>()..add(GetSettingsEvent()),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: appRouter,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            themeMode: state.settings?.themeMode,
            darkTheme: AppTheme.darkTheme,
          );
        },
      ),
    );
  }
}
