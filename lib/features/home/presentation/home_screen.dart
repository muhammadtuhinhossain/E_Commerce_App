import 'package:crafty_bay/features/home/presentation/screens/widget/home_category_section.dart';
import 'package:crafty_bay/features/home/presentation/screens/widget/section_header.dart';
import 'package:crafty_bay/features/home/presentation/widget/home_app_bar.dart';
import 'package:crafty_bay/features/home/presentation/widget/home_carousel_slider.dart';
import 'package:crafty_bay/features/home/presentation/widget/product_search_bar.dart';
import 'package:crafty_bay/features/shared/presentation/presentation/provider/main_nav_holder_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme= TextTheme.of(context);
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
              SectionHeader(headerText: 'Category', onTapSeeAll: () {
                context.read<MainNavHolderProvider>().navigateToCategory();
              }),
              HomeCategorySection(),
              SectionHeader(headerText: 'Popular', onTapSeeAll: () {}
              ),
              SingleChildScrollView(
                scrollDirection: .horizontal,
                child: Row(
                  children: [1, 2, 3, 4, 5].map((e)=>ProductCard()).toList(),
                ),
              ),
              SectionHeader(headerText: 'Special', onTapSeeAll: () {}
              ),
              SingleChildScrollView(
                scrollDirection: .horizontal,
                child: Row(
                  children: [1, 2, 3, 4, 5].map((e)=>ProductCard()).toList(),
                ),
              ),
              SectionHeader(headerText: 'New', onTapSeeAll: () {}
              ),
              SingleChildScrollView(
                scrollDirection: .horizontal,
                child: Row(
                  children: [1, 2, 3, 4, 5].map((e)=>ProductCard()).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
