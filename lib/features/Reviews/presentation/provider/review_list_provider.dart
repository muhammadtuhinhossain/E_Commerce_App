import 'package:flutter/material.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';
import '../../../../core/service/network_caller/network_caller.dart';
import '../../data/models/review_model.dart';

class ReviewListProvider extends ChangeNotifier{

  bool _isLoading = false;
  String? _errorMessage;
  List<ReviewModel> _reviewList = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<ReviewModel> get reviewList => _reviewList;

  Future<bool> getReviewList(String productId)async{
    bool isSuccess = false;
    _isLoading = true;
    notifyListeners();

    final NetworkResponse response = await getNetWorkCaller().getRequest(
      Urls.reviewListUrl(productId),
    );

    try {
      if(response.isSuccess){
        _reviewList = response.body['data']['results']
            .map<ReviewModel>((item)=> ReviewModel.fromJson(item))
        //Individual reviews for each product
            //.where((review) => review.productId == productId)
            .toList();
        isSuccess = true;
        _errorMessage = null;
      }else{
        _errorMessage = response.errorMessage;
      }
    } catch (e) {
      _errorMessage = 'Something went wrong while loading reviews';
    }

    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }

  double get averageRating {
    if(_reviewList.isEmpty) return 0;
    double total = 0;
    for(final review in _reviewList){
      total += review.rating;
    }
    return total / _reviewList.length;
  }

  int get reviewCount => _reviewList.length;
}