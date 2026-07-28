import 'package:flutter/material.dart';

import '../../../../app/providers/auth_controller.dart';
import '../../data/models/review_model.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    super.key, required this.review, required this.onTapEdit,
  });

  final ReviewModel review;
  final VoidCallback onTapEdit;

  @override
  Widget build(BuildContext context) {
    final bool isMyReview = review.userId == AuthController.user?.id;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                spacing: 10,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                    child: Icon(Icons.person_outline_outlined,color: Colors.grey.shade500,size: 18,),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text('${review.firstName} ${review.lastName}',style: TextStyle(fontSize: 18, fontWeight: .w500),),
                        Row(
                          children: List.generate(5, (index){
                            return Icon(
                              index < review.rating ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 16,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  if(isMyReview)
                    IconButton(
                      onPressed: onTapEdit,
                      icon: Icon(Icons.edit_outlined, size: 20),
                    ),
                ],
              ),
              const SizedBox(height: 12,),
              Text(review.comment),
            ],
          ),
          const SizedBox(height: 12,),
          Divider(),
        ],
      ),
    );
  }
}