import 'package:crafty_bay/features/shared/presentation/widget/centered_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/review_list_provider.dart';
import '../widgets/review_and_cart_section.dart';
import '../widgets/review_widget.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.productId});

  final String productId;

  static const String name = '/review-screen';

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {

  final ReviewListProvider _reviewListProvider = ReviewListProvider();

  @override
  void initState() {
    super.initState();
    _reviewListProvider.getReviewList(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _reviewListProvider,
      child: Scaffold(
        appBar: AppBar(title: Text('Reviews'),),
          body: Consumer<ReviewListProvider>(
            builder: (context, reviewListProvider, _) {
              if(reviewListProvider.isLoading){
                return const CenteredProgressIndicator();
              }
              if(reviewListProvider.errorMessage != null){
                return Center(child: Text(reviewListProvider.errorMessage!));
              }
              return Column(
                children: [
                  Expanded(
                    child: reviewListProvider.reviewList.isEmpty 
                        ? Center(child: Text('No reviews yet')) 
                        : Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView.builder(
                        itemCount: reviewListProvider.reviewList.length,
                        itemBuilder: (context, index) {
                          return ReviewWidget(review: reviewListProvider.reviewList[index],);
                        },
                      ),
                    ),
                  ),
                  ReviewAndCartSection(
                    productId: widget.productId,
                    reviewCount: reviewListProvider.reviewList.length,
                    onReviewAdded: () => _reviewListProvider.getReviewList(widget.productId),
                  ),
                ],
              );
            }
          ),
      ),
    );
  }
}

