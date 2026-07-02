import 'package:flutter/material.dart';

import '../widgets/review_and_cart_section.dart';
import '../widgets/review_widget.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  static const String name = '/review-screen';

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reviews'),),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return const ReviewWidget();
                  },
                ),
              ),
            ),
            const ReviewAndCartSection(),
          ],
        ),
    );
  }
}

