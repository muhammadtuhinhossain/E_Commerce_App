import 'package:crafty_bay/app/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/asset_path.dart';
import '../../../../app/constants.dart';
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
                              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color),),

                            Visibility(
                              visible: _hasVariant,
                              child: Text(_variantText,
                                style: TextStyle(color: Theme.of(context).textTheme.labelLarge?.color),),
                            ),
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
                      Text('${Constants.takaSign} ${NumberFormat.decimalPattern(Localizations.localeOf(context).languageCode).format(cartItemModel.product.price)}',
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
  bool get _hasVariant => cartItemModel.color != null || cartItemModel.size != null;

  String get _variantText{
    final List<String> parts = [];
    if(cartItemModel.color != null){
      parts.add('Color: ${cartItemModel.color}');
    }
    if(cartItemModel.size != null){
      parts.add('Size: ${cartItemModel.size}');
    }
    return parts.join('    ');
  }

  Future<void> _onTapDelete(BuildContext context)async{
    final cartListProvider = context.read<CartListProvider>();
    final bool isSuccess = await cartListProvider.deleteCartItem(cartItemModel.id);

    if(context.mounted == false) return;

    if(isSuccess == false){
      showSnackBarMessage(context, cartListProvider.errorMessage ?? context.localization.failedToDeleteItem);
    }
  }
}