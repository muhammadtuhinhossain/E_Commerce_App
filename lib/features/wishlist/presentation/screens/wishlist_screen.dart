import 'package:crafty_bay/features/shared/presentation/presentation/provider/main_nav_holder_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  static const String name= '/wishlist';

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_,_)=>_backToHome(),
      child: Scaffold(
        appBar: AppBar(title: Text('Wishlist'),
        leading: IconButton(onPressed: _backToHome, icon: Icon(Icons.arrow_back_ios)),
        ),
        body: GridView.builder(
            itemCount: 12,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 4,
            ), 
            itemBuilder: (context, index){
              return FittedBox(child: ProductCard());
            }
        ),
      ),
    );
  }
  void _backToHome(){
    context.read<MainNavHolderProvider>().backToHome();
  }
}
