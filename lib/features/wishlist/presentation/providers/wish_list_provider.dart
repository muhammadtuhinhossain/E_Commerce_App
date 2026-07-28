import 'package:flutter/material.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';
import '../../../../core/service/network_caller.dart';
import '../../../shared/data/models/product_model.dart';
import '../../data/models/wishlist_model.dart';

class WishlistProvider extends ChangeNotifier{

  final int _productsPerPage = 32;

  bool _isInitialLoading = false;
  bool _isLoadingMore = false;
  String? _errorMessage;

  int? _lastPage;
  int _currentPage = 0;

  final List<WishlistModel> _wishListItem = [];
  final Set<String> _pendingToggle = {};

  bool get isInitialLoading => _isInitialLoading;
  bool get isLoadingMore => _isLoadingMore;
  String? get errorMessage => _errorMessage;
  List<WishlistModel> get productList => _wishListItem;
  bool get isLoading => _isInitialLoading || _isLoadingMore;

  Future<bool> getWishlistData()async{
    bool isSuccess = false;

    if(_currentPage == 0 || (_lastPage != null && _currentPage < _lastPage!)){
      _currentPage ++;
    }else{
      return false;
    }
    if(_currentPage == 1){
      _isInitialLoading = true;
    }else{
      _isLoadingMore = true;
    }
    notifyListeners();

    final NetworkResponse response = await getNetWorkCaller().getRequest(
      Urls.wishlistUrl(_currentPage, _productsPerPage),
    );

    if(response.isSuccess){
      List<WishlistModel> list = [];
      for(Map<String, dynamic> jsonData in response.body['data']['results']){
        list.add(WishlistModel.fromJson(jsonData));
      }
      _wishListItem.addAll(list);
      _lastPage = response.body['data']['last_page'];
      isSuccess = true;
      _errorMessage = null;
    }else{
      _errorMessage = response.errorMessage;
    }

    if(_currentPage == 1){
      _isInitialLoading = false;
    }else{
      _isLoadingMore = false;
    }
    notifyListeners();
    return isSuccess;
  }

  Future<void> _resyncFromServer()async{
    _currentPage = 0;
    _lastPage = null;
    _wishListItem.clear();
    await getWishlistData();
  }

  void refreshWishlist(){
    _currentPage = 0;
    _lastPage = null;
    _wishListItem.clear();
    getWishlistData();
  }

  bool isInWishlist(String productId){
    return _wishListItem.any((item)=> item.productModel.id == productId);
  }

  String? _getWishlistItemId(String productId){
    for(final item in _wishListItem){
      if(item.productModel.id == productId){
        return item.cartId;
      }
    }
    return null;
  }

  Future<bool> toggleWishlist(ProductModel productModel)async{

    if(_pendingToggle.contains(productModel.id)){
      return false;
    }
    _pendingToggle.add(productModel.id);

    bool result;
    if(isInWishlist(productModel.id)){
      result = await _removeFromWishlist(productModel.id);
    }else{
      result = await _addToWishlist(productModel);
    }

    _pendingToggle.remove(productModel.id);
    return result;
  }

  Future<bool> _addToWishlist(ProductModel productModel)async{
    final NetworkResponse response = await getNetWorkCaller().postRequest(
      Urls.addToWishlistUrl,
      body: {"product": productModel.id},
    );

    if(response.isSuccess){
      final String wishlistItemId = response.body['data']['_id'];
      _wishListItem.add(WishlistModel(cartId: wishlistItemId, productModel: productModel));
      notifyListeners();
      return true;
    }else{
      final String message = response.errorMessage ?? '';
      if(message.toLowerCase().contains('already')){
        await _resyncFromServer();
        return true;
      }
      _errorMessage = response.errorMessage;
      notifyListeners();
      return false;
    }
  }

  Future<bool> _removeFromWishlist(String productId)async{
    final String? wishlistItemId = _getWishlistItemId(productId);
    if(wishlistItemId == null) return false;

    final NetworkResponse response = await getNetWorkCaller().deleteRequest(
      Urls.removeFromWishlistUrl(wishlistItemId),
    );

    if(response.isSuccess){
      _wishListItem.removeWhere((item)=> item.productModel.id == productId);
      notifyListeners();
      return true;
    }else{
      _errorMessage = response.errorMessage;
      notifyListeners();
      return false;
    }
  }

}