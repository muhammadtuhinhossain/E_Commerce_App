import 'package:crafty_bay/features/home/presentation/widget/home_app_bar.dart';
import 'package:crafty_bay/features/home/presentation/widget/home_carousel_slider.dart';
import 'package:crafty_bay/features/home/presentation/widget/product_search_bar.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            children: [
              ProductSearchBar(),
              HomeCarouselSlider(),
            ],
          ),
        ),
      ),
    );
  }
}




