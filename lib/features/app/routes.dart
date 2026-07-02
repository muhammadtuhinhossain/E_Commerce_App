import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:crafty_bay/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:crafty_bay/features/products/presentation/screens/product_list_by_category_screen.dart';
import 'package:crafty_bay/features/shared/presentation/screens/main_nav_holder_screen.dart';
import 'package:flutter/material.dart';

import '../Reviews/presentation/screens/review_screen.dart';
import '../auth/presentation/screens/splash_screen.dart';
import '../products/presentation/screens/product_details_screen.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings){
    Widget widget = SizedBox();

    switch (settings.name){
      case SplashScreen.name:
        widget = SplashScreen();
      case SignInScreen.name:
        widget = SignInScreen();
      case SignUpScreen.name:
        widget = SignUpScreen();
      case VerifyOtpScreen.name:
        widget = VerifyOtpScreen();
      case MainNavHolderScreen.name:
        widget = MainNavHolderScreen();
      case ProductListByCategoryScreen.name:
        Map<String, dynamic> args=settings.arguments as Map<String, dynamic>;
        widget = ProductListByCategoryScreen(
            categoryId: args['categoryId'],
            categoryName: args['categoryName'],
        );
      case ProductDetailsScreen.name:
        final String productId = settings.arguments as String;
        widget = ProductDetailsScreen(productId: productId);

      case ReviewScreen.name:
        widget = ReviewScreen();
    }
    return MaterialPageRoute(builder: (ctx)=> widget);
  }
}