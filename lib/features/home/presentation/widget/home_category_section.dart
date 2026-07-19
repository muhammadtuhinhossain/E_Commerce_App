import 'package:crafty_bay/features/category/presentation/provider/category_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/app_colors.dart';
import '../../../shared/presentation/widget/category_card.dart';

class HomeCategorySection extends StatelessWidget {
  const HomeCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Consumer<CategoryListProvider>(
        builder: (context, categoryListProvider, _) {
          if(categoryListProvider.isInitialLoading){
            return SizedBox(
              height: 110,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return ListView.separated(
            scrollDirection: .horizontal,
            itemCount: categoryListProvider.categoryList.length > 10 
            ?10
            :categoryListProvider.categoryList.length,
            itemBuilder: (context, index) {
              return CategoryCard(categoryModel: categoryListProvider.categoryList[index],);
            },
            separatorBuilder: (_, _) => SizedBox(width: 8),
          );
        }
      ),
    );
  }
}

