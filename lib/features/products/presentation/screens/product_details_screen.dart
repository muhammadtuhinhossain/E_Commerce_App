import 'package:crafty_bay/features/products/presentation/providers/product_details_provider.dart';
import 'package:crafty_bay/features/products/presentation/widgets/price_and_cart_section.dart';
import 'package:crafty_bay/features/shared/presentation/widget/centered_progress_indicator.dart';
import 'package:crafty_bay/features/shared/presentation/widget/inc_dec_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  final ProductDetailsProvider _productDetailsProvider = ProductDetailsProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productDetailsProvider.getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider.value(
      value: _productDetailsProvider,
      child: Scaffold(
        appBar: AppBar(title: Text('Product Details'),),
        body: Consumer<ProductDetailsProvider>(
          builder: (context ,_ ,_) {
            if(_productDetailsProvider.getProductDetailsInProgress){
              return CenteredProgressIndicator();
            }
            if(_productDetailsProvider.errorMessage != null){
              return Center(child: Text(_productDetailsProvider.errorMessage!));
            }
            final productModel = _productDetailsProvider.productDetails!;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ProductImageCarousel(photos: productModel.photos,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                             const SizedBox(height: 16,),
                              Row(
                                children: [
                                  Expanded(child:
                                  Text(productModel.title,
                                  style: textTheme.titleMedium?.copyWith(fontSize: 18, color: Colors.black54),
                                  )),
                                  SizedBox(
                                      width: 90,
                                      child: IncDecButton(
                                        maxCount: productModel.quantity,
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
                                      Text("${productModel.rating}")
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
                              Visibility(
                                visible: productModel.colors.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    _selectedHeader('Color'),
                                    const SizedBox(height: 12,),
                                    ColorPicker(
                                      colors: productModel.colors,
                                      onChange: (String selectedColor) {
                                      print(selectedColor);
                                      },),

                                    const SizedBox(height: 16,),
                                  ],
                                ),
                              ),

                              Visibility(
                                visible: productModel.sizes.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    _selectedHeader('Size'),
                                    const SizedBox(height: 12,),
                                    SizePicker(
                                      sizes: productModel.sizes,
                                      onChange: (String selectedSize) {
                                        print(selectedSize);
                                      },),

                                    const SizedBox(height: 16,),
                                    _selectedHeader('Description'),
                                    const SizedBox(height: 12,),
                                  ],
                                ),
                              ),

                              Text(productModel.description),
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
            );
          }
        ),
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
