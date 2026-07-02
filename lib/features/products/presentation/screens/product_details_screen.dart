import 'package:crafty_bay/features/products/presentation/widgets/price_and_cart_section.dart';
import 'package:crafty_bay/features/shared/presentation/widget/inc_dec_button.dart';
import 'package:flutter/material.dart';

import '../../../Reviews/presentation/screens/review_screen.dart';
import '../../../app/app_colors.dart';
import '../widgets/color_picker.dart';
import '../widgets/product_image_carousel.dart';
import '../widgets/size_picker.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  static const String name = '/product-details';

  final String productId;


  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text('Product Details'),),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProductImageCarousel(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                       const SizedBox(height: 16,),
                        Row(
                          children: [
                            Expanded(child: Text('Adidas Sneaker New Edition 2026 Black',
                            style: textTheme.titleMedium?.copyWith(fontSize: 18, color: Colors.black54),
                            )),
                            SizedBox(
                                width: 90,
                                child: IncDecButton(
                                  maxCount: 20,
                                  minCount: 1,
                                  initialValue: 1,
                                  onChange: (newValue){},)
                            ),
                          ],
                        ),
                        Wrap(
                          spacing: 8,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Wrap(
                              spacing: 4,
                              children: [
                                Icon(Icons.star,color: Colors.amber,size: 20,),
                                Text('4.5')
                              ],
                            ),
                            TextButton(onPressed: (){
                              Navigator.pushNamed(context, ReviewScreen.name);
                            }, child: Text('Reviews')),
                            Container(
                              padding: .all(2),
                              decoration: BoxDecoration(
                                borderRadius: .circular(4),
                                color: AppColors.themeColor,
                              ),
                              child: Icon(Icons.favorite_outline,size: 18,color: Colors.white,),
                            )
                          ],
                        ),
                        const SizedBox(height: 16,),
                        _selectedHeader('Color'),
                        const SizedBox(height: 12,),
                        ColorPicker(colors: ['White','Yellow','Blue','Black'],
                          onChange: (String selectedColor) {
                          print(selectedColor);
                          },),

                        const SizedBox(height: 16,),
                        _selectedHeader('Size'),
                        const SizedBox(height: 12,),
                        SizePicker(sizes: ['S','M','L','XL'],
                          onChange: (String selectedSize) {
                            print(selectedSize);
                          },),

                        const SizedBox(height: 16,),
                        _selectedHeader('Description'),
                        const SizedBox(height: 12,),
                        Text('''There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum'''),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16,),
                ],
              ),
            ),
          ),
          PriceAndCartSection(),
        ],
      ),
    );
  }
  Widget _selectedHeader(String header){
    return Text( header,
      style: TextStyle(
          color: Colors.black54,
          fontSize: 18,
          fontWeight: .w500
      ),);
  }
}
