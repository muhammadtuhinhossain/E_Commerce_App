import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
import '../../../app/constants.dart';
class ReviewAndCartSection extends StatelessWidget {
  const ReviewAndCartSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(16),
      decoration: BoxDecoration(
        borderRadius: .only(topLeft: .circular(8), topRight: .circular(8)),
        color: AppColors.themeColor.withAlpha(30),
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              Text('Review  (1000)', style: TextStyle(fontWeight: .w600),),
            ],
          ),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              shape: const CircleBorder(),
              fixedSize: const Size(50, 50),
              padding: EdgeInsets.zero,
            ),
            child: const Icon(Icons.add,size: 28,),
          ),
        ],
      ),
    );
  }
}