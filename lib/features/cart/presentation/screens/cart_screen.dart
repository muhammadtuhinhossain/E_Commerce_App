import 'package:crafty_bay/features/app/app_colors.dart';
import 'package:crafty_bay/features/app/asset_path.dart';
import 'package:crafty_bay/features/app/constants.dart';
import 'package:crafty_bay/features/cart/presentation/providers/cart_list_provider.dart';
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

  final CartListProvider _cartListProvider = CartListProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartListProvider.getCartList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _cartListProvider,
      child: PopScope(
        onPopInvokedWithResult: (_,_)=> _backToHome(),
        child: Scaffold(
          appBar: AppBar(title: Text('Cart'),
          leading: IconButton(onPressed: _backToHome, icon: Icon(Icons.arrow_back_ios)),
          ),
          body: Consumer<CartListProvider>(
            builder: (context, _, _) {
              if(_cartListProvider.isLoading){
                return Center(child: CircularProgressIndicator());
              }
              if(_cartListProvider.errorMessage != null){
                return Center(child: Text(_cartListProvider.errorMessage!));
              }

              return Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                        itemCount: _cartListProvider.cartList.length,
                          itemBuilder: (context, index){
                          return CartItem(
                            cartItemModel: _cartListProvider.cartList[index],
                          );
                          }
                      )
                  ),
                  TotalPriceAndCheckoutSection()
                ],
              );
            }
          ),
        ),
      ),
    );
  }
  void _backToHome(){
    context.read<MainNavHolderProvider>().backToHome();
  }
}




