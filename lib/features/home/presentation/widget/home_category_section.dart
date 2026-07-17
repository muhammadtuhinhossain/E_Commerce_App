import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
import '../../../shared/presentation/widget/category_card.dart';

class HomeCategorySection extends StatelessWidget {
  const HomeCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: .horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          //return CategoryCard();
        },
        separatorBuilder: (_, _) => SizedBox(width: 8),
      ),
    );
  }
}

