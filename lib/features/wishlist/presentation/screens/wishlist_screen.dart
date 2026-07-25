import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/provider/main_nav_holder_provider.dart';
import '../../../shared/presentation/widget/centered_progress_indicator.dart';
import '../../../shared/presentation/widget/product_card.dart';
import '../providers/wish_list_provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  static const String name = '/wishlist';

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);
  }

  void _loadMore() {
    final wishlistProvider = context.read<WishlistProvider>();
    if ((wishlistProvider.isLoading == false) &&
        _scrollController.position.extentAfter < 300) {
      wishlistProvider.getWishlistData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, _) => _backToHome(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Wishlist'),
          leading: IconButton(
            onPressed: _backToHome,
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Consumer<WishlistProvider>(
          builder: (context, wishlistProvider, _) {
            if (wishlistProvider.isInitialLoading) {
              return const CenteredProgressIndicator();
            }
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    itemCount: wishlistProvider.productList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 4,
                    ),
                    itemBuilder: (context, index) {
                      return FittedBox(
                        child: ProductCard(
                          productModel: wishlistProvider.productList[index].productModel,
                        ),
                      );
                    },
                  ),
                ),
                if (wishlistProvider.isLoadingMore) LinearProgressIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }

  void _backToHome() {
    context.read<MainNavHolderProvider>().backToHome();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

// class _WishlistScreenState extends State<WishlistScreen> {
//   final WishlistProvider _wishlistProvider = WishlistProvider();
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     _wishlistProvider.getWishlistData();
//     _scrollController.addListener(_loadMore);
//   }
//
//   void _loadMore() {
//     if ((_wishlistProvider.isLoading == false) &&
//         _scrollController.position.extentAfter < 300) {
//       _wishlistProvider.getWishlistData();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (_, _) => _backToHome(),
//       child: ChangeNotifierProvider.value(
//         value: _wishlistProvider,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text('Wishlist'),
//             leading: IconButton(
//               onPressed: _backToHome,
//               icon: Icon(Icons.arrow_back_ios),
//             ),
//           ),
//           body: Consumer<WishlistProvider>(
//             builder: (context, wishlistProvider, _) {
//               if (wishlistProvider.isInitialLoading) {
//                 return const CenteredProgressIndicator();
//               }
//               return Column(
//                 children: [
//                   Expanded(
//                     child: GridView.builder(
//                       controller: _scrollController,
//                       itemCount: wishlistProvider.productList.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         mainAxisSpacing: 8,
//                         crossAxisSpacing: 4,
//                       ),
//                       itemBuilder: (context, index) {
//                         return FittedBox(
//                           child: Stack(
//                             children: [
//                               ProductCard(
//                                 productModel: wishlistProvider
//                                     .productList[index]
//                                     .productModel,
//                               ),
//                               Positioned(
//                                 right: 10,
//                                 top: 10,
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     _onTapRemoveItem(
//                                       wishlistProvider
//                                           .productList[index]
//                                           .cartId,
//                                     );
//                                   },
//                                   child: CircleAvatar(
//                                     child: Icon(Icons.close_outlined),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   if (wishlistProvider.isLoadingMore) LinearProgressIndicator(),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _onTapRemoveItem(String itemId) {}
//
//   void _backToHome() {
//     context.read<MainNavHolderProvider>().backToHome();
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
// }
