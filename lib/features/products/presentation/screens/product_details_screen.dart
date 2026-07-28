import 'package:crafty_bay/features/wishlist/presentation/providers/wish_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extensions/localization_extension.dart';
import '../../../../app/providers/auth_controller.dart';
import '../../../Reviews/presentation/provider/review_list_provider.dart';
import '../../../Reviews/presentation/screens/review_screen.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';
import '../../../cart/data/models/add_to_cart_params.dart';
import '../../../cart/presentation/providers/add_to_cart_provider.dart';
import '../../../shared/data/models/product_model.dart';
import '../../../shared/presentation/widget/centered_progress_indicator.dart';
import '../../../shared/presentation/widget/inc_dec_button.dart';
import '../../../shared/presentation/widget/snack_bar_message.dart';
import '../providers/product_details_provider.dart';
import '../widgets/color_picker.dart';
import '../widgets/price_and_cart_section.dart';
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
  final AddToCartProvider _addToCartProvider = AddToCartProvider();
  final ReviewListProvider _reviewListProvider = ReviewListProvider();

  String? _selectedColor;
  String? _selectedSize;
  int _quantity = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productDetailsProvider.getProductDetails(widget.productId);
    _reviewListProvider.getReviewList(widget.productId);
  }

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _productDetailsProvider),
        ChangeNotifierProvider.value(value: _reviewListProvider),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(context.localization.productDetails),),
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
                                        initialValue: _quantity,
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
                                      Consumer<ReviewListProvider>(
                                        builder: (context, reviewListProvider, _) {
                                          return Text(reviewListProvider.averageRating.toStringAsFixed(1));
                                        }
                                      )
                                    ],
                                  ),
                                  TextButton(onPressed: (){
                                    Navigator.pushNamed(context, ReviewScreen.name, arguments: productModel.id);
                                  }, child: Text(context.localization.reviews)),
                                  Consumer<WishlistProvider>(
                                    builder: (context, wishlistProvider, _) {
                                      final bool isFavorite = wishlistProvider.isInWishlist(productModel.id);
                                      return GestureDetector(
                                        onTap: () => _onTapFavorite(context, wishlistProvider, productModel),
                                        child: Container(
                                          padding: .all(2),
                                          decoration: BoxDecoration(
                                            borderRadius: .circular(4),
                                            color: isFavorite ? Colors.red : AppColors.themeColor,
                                          ),
                                          child: Icon(isFavorite ? Icons.favorite : Icons.favorite_outline,
                                            size: 18,color: Colors.white,),
                                        ),
                                      );
                                    }
                                  )
                                ],
                              ),
                              const SizedBox(height: 16,),
                              Visibility(
                                visible: productModel.colors.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    _selectedHeader(context.localization.color),
                                    const SizedBox(height: 12,),
                                    ColorPicker(
                                      colors: productModel.colors,
                                      onChange: (String selectedColor) {
                                      print(selectedColor);
                                      _selectedColor = selectedColor;
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
                                    _selectedHeader(context.localization.size),
                                    const SizedBox(height: 12,),
                                    SizePicker(
                                      sizes: productModel.sizes,
                                      onChange: (String selectedSize) {
                                        print(selectedSize);
                                        _selectedSize = selectedSize;
                                      },),

                                    const SizedBox(height: 16,),
                                    _selectedHeader(context.localization.description),
                                    const SizedBox(height: 12,),
                                  ],
                                ),
                              ),

                              Text(productModel.description,
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16,),
                      ],
                    ),
                  ),
                ),
                ChangeNotifierProvider.value(
                    value: _addToCartProvider,
                    child: PriceAndCartSection(
                      onTapAddToCart: _onTapAddToCart,
                      price: productModel.currentPrice,
                    ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  Future<void> _onTapFavorite(BuildContext context, WishlistProvider wishlistProvider, productDetails)async{
    final bool isLoggedIn = await AuthController.isLoggedIn();
    if(context.mounted == false) return;

    if(isLoggedIn == false){
      Navigator.pushNamed(context, SignInScreen.name);
      return;
    }

    final ProductModel productModel = ProductModel(
      id: productDetails.id,
      title: productDetails.title,
      photos: productDetails.photos,
      price: productDetails.currentPrice,
      rating: productDetails.rating,
      quantity: productDetails.quantity,
    );

    wishlistProvider.toggleWishlist(productModel);
  }

  Future<void> _onTapAddToCart()async{
    if(await AuthController.isLoggedIn() == false){
      Navigator.pushNamed(context, SignInScreen.name);
      return;
    }
    AddToCartParams params = AddToCartParams(
        productId: widget.productId,
        color: _selectedColor,
        size: _selectedSize,
        quantity: _quantity,
    );
    final isSuccess = await _addToCartProvider.addToCart(params);
    if(isSuccess){
      showSnackBarMessage(context, context.localization.addedToCart);
    }else{
      showSnackBarMessage(context, _addToCartProvider.errorMessage!);
    }
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
