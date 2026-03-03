import 'package:finance/core/dependency_injection.dart';
import 'package:finance/core/routes/app_router.dart';
import 'package:finance/core/theme/app_theme.dart';
import 'package:finance/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:finance/features/settings/presentation/bloc/settings_event.dart';
import 'package:finance/features/settings/presentation/bloc/settings_state.dart';
import 'package:finance/features/settings/presentation/pages/verify_pin_page.dart';
import 'package:finance/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (context) => getIt<SettingsBloc>()..add(GetSettingsEvent()),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          final bool needsPinVerification =
              state.settings?.pinEnabled == true && !_isAuthenticated;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            themeMode: state.settings?.themeMode,
            darkTheme: AppTheme.darkTheme,
            locale: Locale(state.settings?.locale ?? 'en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: needsPinVerification
                ? VerifyPinPage(
                    onSuccess: () {
                      setState(() {
                        _isAuthenticated = true;
                      });
                    },
                  )
                : null,
            builder: (context, child) {
              if (needsPinVerification) {
                return child ?? const SizedBox();
              }
              return MaterialApp.router(
                routerConfig: appRouter,
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                themeMode: state.settings?.themeMode,
                darkTheme: AppTheme.darkTheme,
                locale: Locale(state.settings?.locale ?? 'en'),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
              );
            },
          );
        },
      ),
    );
  }
}
