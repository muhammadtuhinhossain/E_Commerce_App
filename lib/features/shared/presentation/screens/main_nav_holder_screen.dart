import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extensions/localization_extension.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../category/presentation/provider/category_list_provider.dart';
import '../../../category/presentation/screens/category_screen.dart';
import '../../../home/presentation/providers/home_sliders_provider.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../wishlist/presentation/providers/wish_list_provider.dart';
import '../../../wishlist/presentation/screens/wishlist_screen.dart';
import '../provider/main_nav_holder_provider.dart';

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
    CartScreen(),
    WishlistScreen(),
  ];

  final HomeSlidersProvider _homeSlidersProvider = HomeSlidersProvider();
  final CategoryListProvider _categoryListProvider = CategoryListProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeSlidersProvider.getSliders();
    _categoryListProvider.getCategoryData();
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<WishlistProvider>().refreshWishlist();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _homeSlidersProvider),
        ChangeNotifierProvider.value(value: _categoryListProvider),
      ],
      child: Consumer<MainNavHolderProvider>(
        builder: (context,mainNavHolderProvider,_) {
          return Scaffold(
            body: _screens[mainNavHolderProvider.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: mainNavHolderProvider.currentIndex,
              unselectedItemColor: Colors.grey,
                selectedItemColor: AppColors.themeColor,
                showUnselectedLabels: true,
                onTap: mainNavHolderProvider.changeIndex,

                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.home),label: context.localization.home),
                  BottomNavigationBarItem(icon: Icon(Icons.dashboard),label: context.localization.category),
                  BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_outlined),label: context.localization.cart),
                  BottomNavigationBarItem(icon: Icon(Icons.favorite_outline),label: context.localization.wishlist),
                ]),
          );
        }
      ),
    );
  }
}
