import 'package:crafty_bay/features/app/app_colors.dart';
import 'package:crafty_bay/features/app/asset_path.dart';
import 'package:crafty_bay/features/app/constants.dart';
import 'package:crafty_bay/features/shared/presentation/widget/inc_dec_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/provider/main_nav_holder_provider.dart';
import '../widgets/cart_item.dart';
import '../widgets/total_price_and_checkout_section.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_,_)=> _backToHome(),
      child: Scaffold(
        appBar: AppBar(title: Text('Cart'),
        leading: IconButton(onPressed: _backToHome, icon: Icon(Icons.arrow_back_ios)),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  itemCount: 4,
                    itemBuilder: (context, index){
                    return CartItem();
                    }
                )
            ),
            TotalPriceAndCheckoutSection()
          ],
        ),
      ),
    );
  }
  void _backToHome(){
    context.read<MainNavHolderProvider>().backToHome();
  }
}




