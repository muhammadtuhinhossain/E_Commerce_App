import 'package:crafty_bay/features/shared/presentation/widget/product_card.dart';
import 'package:flutter/material.dart';

class ProductListByCategoryScreen extends StatefulWidget {
  const ProductListByCategoryScreen({super.key, required this.categoryId, required this.categoryName});

  final String categoryId;
  final String categoryName;

  static const String name= '/product_list_by_category';

  @override
  State<ProductListByCategoryScreen> createState() => _ProductListByCategoryScreenState();
}

class _ProductListByCategoryScreenState extends State<ProductListByCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName),),
      body: GridView.builder(
        itemCount: 12,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 4,
          ),
          itemBuilder: (context, index){
          return FittedBox(child: ProductCard());
          }
      ),
    );
  }
}
