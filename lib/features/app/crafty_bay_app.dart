import 'package:crafty_bay/features/app/routes.dart';
import 'package:flutter/material.dart';

import '../auth/presentation/screens/splash_screen.dart';

class CraftyBayApp extends StatelessWidget {
  const CraftyBayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crafty Bay',
      //home: SplashScreen(),
      initialRoute: '/Splash',
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}