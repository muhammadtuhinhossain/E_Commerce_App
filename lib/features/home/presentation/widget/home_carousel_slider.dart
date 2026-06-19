import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/features/app/app_colors.dart';
import 'package:flutter/material.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({super.key});

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {

  final ValueNotifier<int>_selectedIndex=ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        CarouselSlider(
          options: CarouselOptions(height: 180.0, viewportFraction: 1,
          autoPlay: true,
          onPageChanged: (index,_){
            _selectedIndex.value= index;
          }
          ),
          items: [1,2,3,4,5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                        color: AppColors.themeColor,
                    ),
                    alignment: Alignment.center,
                    child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                );
              },
            );
          }).toList(),
        ),

        ValueListenableBuilder(
          valueListenable: _selectedIndex,
          builder: (context,index,_) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(int i=0; i<5; i++)
                Container(
                  width: 10,
                  height: 10,
                  margin: .only(right: 2),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.orangeAccent,
                    ),
                    borderRadius: .circular(10),
                    color: i == index ? AppColors.themeColor : Colors.grey.shade300,
                  ),
                )
              ],
            );
          }
        )
      ],
    );
  }
}
