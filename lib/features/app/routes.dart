import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../auth/presentation/screens/splash_screen.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings){
    Widget widget = SizedBox();

    switch (settings.name){
      case SplashScreen.name:
        widget = SplashScreen();
      case SignInScreen.name:
        widget = SignInScreen();
    }
    return MaterialPageRoute(builder: (ctx)=> widget);
  }
}