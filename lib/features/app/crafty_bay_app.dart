import 'package:crafty_bay/features/app/app_theme.dart';
import 'package:crafty_bay/features/app/providers/theme_mode_provider.dart';
import 'package:crafty_bay/features/app/routes.dart';
import 'package:crafty_bay/features/auth/presentation/screens/splash_screen.dart';
import 'package:crafty_bay/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class CraftyBayApp extends StatefulWidget {
  const CraftyBayApp({super.key});

  @override
  State<CraftyBayApp> createState() => _CraftyBayAppState();
}

class _CraftyBayAppState extends State<CraftyBayApp> {
  
  final ThemeModeProvider _themeModeProvider = ThemeModeProvider();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _themeModeProvider.setDefaultThemeMode();
  }
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: _themeModeProvider)],
      child: Consumer<ThemeModeProvider>(
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
            supportedLocales: [
              Locale('en'),
              Locale('bn'),
            ],
            locale: Locale('bn'),
          );
        }
      ),
    );
  }
}