import 'package:crafty_bay/core/service/network_caller.dart';
import 'package:crafty_bay/features/app/get_network_caller.dart';
import 'package:crafty_bay/features/app/urls.dart';
import 'package:crafty_bay/features/cart/data/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartListProvider extends ChangeNotifier{
  List<CartItemModel> _cartList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<CartItemModel> get cartList => _cartList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> getCartList()async{
    bool isSuccess = false;
    _isLoading = true;
    notifyListeners();

    final NetworkResponse response = await getNetWorkCaller().getRequest(
      Urls.cartListUrl
    );
    if(response.isSuccess){
      _cartList = response.body['data']['result']
          .map<CartItemModel>((item)=> CartItemModel.fromJson(item))
          .toList();

      isSuccess = true;
      _errorMessage = null;
    }else{
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }

  int get totalPrice{
    int total = 0;
    for(CartItemModel item in _cartList){
      total += item.product.price * item.quantity;
    }
    return total;
  }
  void updateCartItemQuantity(String cartItemId, int quantity){
    for(CartItemModel item in _cartList){
      if(item.id == cartItemId){
        item.quantity = quantity;
        break;
      }
    }
    notifyListeners();
  }
}