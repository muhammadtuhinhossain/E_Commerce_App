import 'package:crafty_bay/features/app/app_colors.dart';
import 'package:crafty_bay/features/category/presentation/screens/category_screen.dart';
import 'package:crafty_bay/features/shared/presentation/presentation/provider/main_nav_holder_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../home/presentation/home_screen.dart';

class MainNavHolderScreen extends StatefulWidget {
  const MainNavHolderScreen({super.key});

  static const String name='/main-nve-holder';

  @override
  State<MainNavHolderScreen> createState() => _MainNavHolderScreenState();
}

class _MainNavHolderScreenState extends State<MainNavHolderScreen> {

  final List<Widget> _screens=[
    HomeScreen(),
    CategoryScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainNavHolderProvider>(
      builder: (context,mainNavHolderProvider,_) {
        return Scaffold(
          body: _screens[mainNavHolderProvider.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: mainNavHolderProvider.currentIndex,
            unselectedItemColor: Colors.grey,
              selectedItemColor: AppColors.themeColor,
              showSelectedLabels: true,
              onTap: mainNavHolderProvider.changeIndex,

              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.dashboard),label: 'Category'),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_outlined),label: 'Carts'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite_outline),label: 'WishList'),
              ]),
        );
      }
    );
  }
}
