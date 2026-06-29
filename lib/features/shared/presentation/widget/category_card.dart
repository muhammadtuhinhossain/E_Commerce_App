import 'package:crafty_bay/features/products/presentation/screens/product_list_by_category_screen.dart';
import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, ProductListByCategoryScreen.name,arguments: {
          'categoryId': "sfsklfjkjf-sdjk-dfkdj",
          'categoryName': 'Electronic',
        });
      },
      child: Column(
        children: [
          Container(
            padding: .all(16),
            decoration: BoxDecoration(
              color: AppColors.themeColor.withAlpha(20),
              borderRadius: .circular(8),
            ),
            child: Icon(
              Icons.computer,
              size: 48,
              color: AppColors.themeColor,
            ),
          ),
          SizedBox(height: 4,),
          Text('Electronics',style: TextStyle(fontWeight: .w500,color: AppColors.themeColor),),
        ],
      ),
    );
  }
}