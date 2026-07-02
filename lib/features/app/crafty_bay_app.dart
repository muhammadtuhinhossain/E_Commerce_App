import 'package:crafty_bay/features/app/app_theme.dart';
import 'package:crafty_bay/features/app/providers/locale_provider.dart';
import 'package:crafty_bay/features/app/providers/theme_mode_provider.dart';
import 'package:crafty_bay/features/app/routes.dart';
import 'package:crafty_bay/features/auth/presentation/screens/splash_screen.dart';
import 'package:crafty_bay/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../shared/presentation/provider/main_nav_holder_provider.dart';

class CraftyBayApp extends StatefulWidget {
  const CraftyBayApp({super.key});

  @override
  State<CraftyBayApp> createState() => _CraftyBayAppState();
}

class _CraftyBayAppState extends State<CraftyBayApp> {
  
  final ThemeModeProvider _themeModeProvider = ThemeModeProvider();
  final LocaleProvider _localeProvider = LocaleProvider();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _themeModeProvider.setDefaultThemeMode();
    _localeProvider.setDefaultLocale();
  }
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _themeModeProvider),
        ChangeNotifierProvider.value(value: _localeProvider),
        ChangeNotifierProvider(create: (_)=> MainNavHolderProvider()),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context,localProvider,_) {
          return Consumer<ThemeModeProvider>(
            builder: (context, themeModeProvider, _) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Crafty Bay',
                initialRoute: SplashScreen.name,
                onGenerateRoute: AppRoutes.onGenerateRoute,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeModeProvider.themeMode,

                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: localProvider.supportedLocales,
                locale: localProvider.currentLocale,
              );
            }
          );
        }
      ),
    );
  }
}