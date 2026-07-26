import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/app_colors.dart';
import '../../../app/asset_path.dart';
import '../../../app/constants.dart';
import '../../../shared/presentation/widget/inc_dec_button.dart';
import '../../../shared/presentation/widget/snack_bar_message.dart';
import '../../data/models/cart_model.dart';
import '../providers/cart_list_provider.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key, required this.cartItemModel,
  });

  final CartItemModel cartItemModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: .symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetPath.dummyPng, width: 100,),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                spacing: 8,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text( cartItemModel.product.title,
                              style: TextStyle(fontSize: 16),),
                            Text('Color: ${cartItemModel.color ?? ''}    Size: ${cartItemModel.size ?? ''}',
                              style: TextStyle(color: Colors.black54),),
                          ],
                        ),
                      ),
                      IconButton(onPressed: (){
                        _onTapDelete(context);
                      }, icon: Icon(Icons.delete_outline,color: Colors.red.shade300,)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text('${Constants.takaSign} ${cartItemModel.product.price}',
                        style: TextStyle(fontWeight: .w600,
                            fontSize: 18, color: AppColors.themeColor),
                      ),
                      SizedBox(
                        width: 90,
                        child: IncDecButton(
                            maxCount: cartItemModel.product.quantity,
                            minCount: 1,
                            initialValue: cartItemModel.quantity,
                            onChange: (int value){
                              context.read<CartListProvider>().updateCartItemQuantity(
                                  cartItemModel.id,
                                  value,
                              );
                            }
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _onTapDelete(BuildContext context)async{
    final cartListProvider = context.read<CartListProvider>();
    final bool isSuccess = await cartListProvider.deleteCartItem(cartItemModel.id);

    if(context.mounted == false) return;

    if(isSuccess == false){
      showSnackBarMessage(context, cartListProvider.errorMessage ?? 'Failed to delete item');
    }
  }
}