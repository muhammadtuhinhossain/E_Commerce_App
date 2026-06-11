import 'package:flutter/material.dart';

import '../auth/presentation/screens/splash_screen.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings){
    Widget widget = SizedBox();

    switch (settings.name){
      case SplashScreen.name:
        widget = SplashScreen();
        break;
    }
    return MaterialPageRoute(builder: (ctx)=> widget);
  }
}