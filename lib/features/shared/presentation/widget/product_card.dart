import 'package:crafty_bay/features/wishlist/presentation/providers/wish_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/asset_path.dart';
import '../../../../app/constants.dart';
import '../../../../app/providers/auth_controller.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';
import '../../data/models/product_model.dart';
import '../../../products/presentation/screens/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productModel,});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {

    final textTheme= TextTheme.of(context);

    return  GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, ProductDetailsScreen.name, arguments: productModel.id);
      },
      child: Card(
        child: SizedBox(
          width: 150,
          child: Column(
            children: [
              Container(
                width: 150,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withAlpha(30),
                  borderRadius: .only(topLeft: .circular(8), topRight: .circular(8)),
                ),
                child: Image.network(getProductPhoto(productModel.photos),
                errorBuilder: (_, _, _)=> Image.asset(AssetPath.dummyPng),
                ),
              ),
              SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: .start,
                  children: [
                    Text(productModel.title,style: TextStyle(
                        fontWeight: .w600,
                        color: Theme.of(context).textTheme.labelLarge?.color),),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text('${Constants.takaSign}${productModel.price}',
                          style: textTheme.bodyLarge?.copyWith(fontWeight: .w600,color: AppColors.themeColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Wrap(
                          children: [
                            Icon(Icons.star,color: Colors.amber,size: 18,),
                            Text('${productModel.rating}'),
                          ],
                        ),
                        SizedBox(width: 4,),
                        Consumer<WishlistProvider>(
                          builder: (context, wishlistProvider, _) {
                            final bool isFavorite = wishlistProvider.isInWishlist(productModel.id);
                            return GestureDetector(
                              onTap: ()=> _onTapFavorite(context, wishlistProvider),
                              child: Container(
                                padding: .all(2),
                                decoration: BoxDecoration(
                                  borderRadius: .circular(4),
                                  color:  isFavorite ? Colors.red : AppColors.themeColor,
                                ),
                                child: Icon(isFavorite ? Icons.favorite : Icons.favorite_outline,
                                  size: 18,color: Colors.white,),
                              ),
                            );
                          }
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4,),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onTapFavorite(BuildContext context, WishlistProvider wishlistProvider)async{
    final bool isLoggedIn = await AuthController.isLoggedIn();
    if(context.mounted == false) return;

    if(isLoggedIn == false){
      Navigator.pushNamed(context, SignInScreen.name);
      return;
    }
    await wishlistProvider.toggleWishlist(productModel);
  }

  String getProductPhoto(List<String> photos){
    if(photos.isEmpty){
      return '';
    }else{
      return photos.first;
    }
  }
}
