import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
import '../../../app/providers/auth_controller.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';
import '../screens/input_review_screen.dart';
class ReviewAndCartSection extends StatelessWidget {
  const ReviewAndCartSection({
    super.key, required this.productId, required this.reviewCount, required this.onReviewAdded,
  });
  final String productId;
  final int reviewCount;
  final VoidCallback onReviewAdded;

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
              Text('Review  ($reviewCount)', style: TextStyle(fontWeight: .w600),),
            ],
          ),
          FilledButton(
            onPressed: () => _onTapAddReview(context),
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
  Future<void> _onTapAddReview(BuildContext context)async{
    final bool isLoggedIn = await AuthController.isLoggedIn();
    if(context.mounted == false) return;

    if(isLoggedIn == false){
      Navigator.pushNamed(context, SignInScreen.name);
      return;
    }

    final isSuccess = await Navigator.pushNamed(
      context,
      InputReviewScreen.name,
      arguments: productId,
    );

    if(isSuccess == true){
      onReviewAdded();
    }
  }
}