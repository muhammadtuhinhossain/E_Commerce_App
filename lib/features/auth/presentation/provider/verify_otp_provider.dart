import 'package:flutter/material.dart';
import '../../../../core/service/network_caller.dart';
import '../../../app/get_network_caller.dart';
import '../../../app/urls.dart';
import '../../data/models/verify_otp_params.dart';

class VerifyOtpProvider extends ChangeNotifier{
  bool _verifyOtInProgress = false;

  bool get verifyOtInProgress => _verifyOtInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> verifyOtp(VerifyOtpParams params)async{
    bool isSuccess = false;
    _verifyOtInProgress = true;
    notifyListeners();
    
    final NetworkResponse response = await getNetWorkCaller().postRequest(Urls.verifyOtpUrl,
    body: params.toJson(),
    );
    if(response.isSuccess){
      isSuccess = true;
      _errorMessage = null;
    }else{
      _errorMessage = response.errorMessage;
    }
    _verifyOtInProgress = false;
    notifyListeners();
    return isSuccess;
  }
}