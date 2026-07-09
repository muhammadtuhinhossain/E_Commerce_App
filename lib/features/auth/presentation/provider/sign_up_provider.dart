import 'package:crafty_bay/core/service/network_caller.dart';
import 'package:crafty_bay/features/app/get_network_caller.dart';
import 'package:crafty_bay/features/app/urls.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/sign_up_params.dart';

class SignUpProvider extends ChangeNotifier{
  bool _signUpInInProgress = false;

  bool get signUpInInProgress => _signUpInInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signUp(SignUpParams params)async{
    bool isSuccess = false;
    _signUpInInProgress = true;
    notifyListeners();
    
    final NetworkResponse response = await getNetWorkCaller().postRequest(Urls.signUpUrl,
    body: params.toJson(),
    );
    if(response.isSuccess){
      isSuccess = true;
      _errorMessage = null;
    }else{
      _errorMessage = response.errorMessage;
    }
    _signUpInInProgress = false;
    notifyListeners();
    return isSuccess;
  }
}