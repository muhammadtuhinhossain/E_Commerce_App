import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
import '../../../app/asset_path.dart';
import '../../../app/constants.dart';
import '../../../shared/presentation/widget/inc_dec_button.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

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
}