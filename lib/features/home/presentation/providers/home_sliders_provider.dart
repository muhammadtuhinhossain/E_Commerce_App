import 'package:flutter/material.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';
import '../../../../core/service/network_caller/network_caller.dart';
import '../../data/models/slider_model.dart';

class HomeSlidersProvider extends ChangeNotifier{

  bool _getSlidersInProgress = false;
  List<SliderModel> _sliders = [];

  String? _errorMessage;

  bool get getSlidersInProgress => _getSlidersInProgress;
  List<SliderModel> get sliders => _sliders;
  String? get errorMessage => _errorMessage;

  Future<bool> getSliders()async{
    bool isSuccess = false;
    _getSlidersInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetWorkCaller().getRequest(Urls.homeSliderUrl);

    if(response.isSuccess){
      List<SliderModel> sliderModel = [];

      for(Map<String, dynamic> model in response.body['data']['results']){
        sliderModel.add(SliderModel.fromJson(model));
      }

      _sliders = sliderModel;
      isSuccess = true;
      _errorMessage = null;
    }else{
      _errorMessage = response.errorMessage;
    }
    _getSlidersInProgress = false;
    notifyListeners();
    return isSuccess;
  }
}