import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/provider/main_nav_holder_provider.dart';
import '../../../shared/presentation/widget/centered_progress_indicator.dart';
import '../../../shared/presentation/widget/product_card.dart';
import '../providers/home_sliders_provider.dart';
import '../widget/home_app_bar.dart';
import '../widget/home_carousel_slider.dart';
import '../widget/home_category_section.dart';
import '../widget/product_search_bar.dart';
import '../widget/section_header.dart';

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
              Consumer<HomeSlidersProvider>(
                builder: (context, homeSliderProvider,_) {
                  if(homeSliderProvider.getSlidersInProgress){
                    return SizedBox(
                        height: 180,
                        child: CenteredProgressIndicator());
                  }
                  return HomeCarouselSlider(
                    sliders: homeSliderProvider.sliders,
                  );
                }
              ),
              SectionHeader(headerText: 'Category', onTapSeeAll: () {
                context.read<MainNavHolderProvider>().navigateToCategory();
              }),
              HomeCategorySection(),
              SectionHeader(headerText: 'Popular', onTapSeeAll: () {}
              ),
              SingleChildScrollView(
                scrollDirection: .horizontal,
                child: Row(
                  //children: [1, 2, 3, 4, 5].map((e)=>ProductCard()).toList(),
                ),
              ),
              SectionHeader(headerText: 'Special', onTapSeeAll: () {}
              ),
              SingleChildScrollView(
                scrollDirection: .horizontal,
                child: Row(
                  //children: [1, 2, 3, 4, 5].map((e)=>ProductCard()).toList(),
                ),
              ),
              SectionHeader(headerText: 'New', onTapSeeAll: () {}
              ),
              SingleChildScrollView(
                scrollDirection: .horizontal,
                child: Row(
                  //children: [1, 2, 3, 4, 5].map((e)=>ProductCard()).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
