import 'package:crafty_bay/features/products/presentation/providers/product_list_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widget/centered_progress_indicator.dart';
import 'package:crafty_bay/features/shared/presentation/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListByCategoryScreen extends StatefulWidget {
  const ProductListByCategoryScreen({super.key, required this.categoryId, required this.categoryName});

  final String categoryId;
  final String categoryName;

  static const String name= '/product_list_by_category';

  @override
  State<ProductListByCategoryScreen> createState() => _ProductListByCategoryScreenState();
}

class _ProductListByCategoryScreenState extends State<ProductListByCategoryScreen> {

  final ProductListProvider _productListProvider = ProductListProvider();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productListProvider.getProductData();
    _scrollController.addListener(_loadMore);
  }

  void _loadMore(){
    if((_productListProvider.isLoading == false) &&
    _scrollController.position.extentBefore < 300){
      _productListProvider.getProductData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _productListProvider,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.categoryName),),

        body: Consumer<ProductListProvider>(
          builder: (context,productListProvider, _) {
            if(productListProvider.isInitialLoading){
              return CenteredProgressIndicator();
            }

            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    itemCount: productListProvider.productList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 4,
                      ),
                      itemBuilder: (context, index){
                      return FittedBox(child: ProductCard(
                        productModel: productListProvider.productList[index],
                      ));
                      }
                  ),
                ),
                if(productListProvider.isLoadingMore)
                  LinearProgressIndicator()
              ],
            );
          }
        ),
      ),
    );
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
