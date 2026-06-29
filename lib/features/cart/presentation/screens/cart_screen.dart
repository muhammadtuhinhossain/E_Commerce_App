import 'package:crafty_bay/features/app/app_colors.dart';
import 'package:crafty_bay/features/app/asset_path.dart';
import 'package:crafty_bay/features/app/constants.dart';
import 'package:crafty_bay/features/shared/presentation/presentation/provider/main_nav_holder_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widget/inc_dec_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                spacing: 8,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: .start,
                                          children: [
                                            Text('Total of Product',style: TextStyle(fontSize: 16),),
                                            Text('color: Red    size: XL',style: TextStyle(color: Colors.black54),),
                                          ],
                                        ),
                                      ),
                                      IconButton(onPressed: (){}, icon: Icon(Icons.delete_outline)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: .spaceBetween,
                                    children: [
                                      Text('${Constants.takaSign}100',
                                        style: TextStyle(fontWeight: .w600,
                                            fontSize: 18, color: AppColors.themeColor),
                                      ),
                                      SizedBox(
                                        width: 90,
                                        child: IncDecButton(
                                            maxCount: 20,
                                            minCount: 1,
                                            initialValue: 1,
                                            onChange: (int value){
                                              print (value);
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


