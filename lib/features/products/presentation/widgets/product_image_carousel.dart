import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/features/app/app_colors.dart';
import 'package:flutter/material.dart';

class ProductImageCarousel extends StatefulWidget {
  const ProductImageCarousel({super.key});

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {

  final ValueNotifier<int>_selectedIndex=ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(height: 220.0, viewportFraction: 1,
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
                      color: Colors.grey.withAlpha(60),
                    ),
                    alignment: Alignment.center,
                    child: Text('image $i', style: TextStyle(fontSize: 16.0),)
                );
              },
            );
          }).toList(),
        ),

        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: ValueListenableBuilder(
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
                          color: i == index
                              ? AppColors.themeColor
                              : Colors.white,
                        ),
                      )
                  ],
                );
              }
          ),
        )
      ],
    );
  }
}
