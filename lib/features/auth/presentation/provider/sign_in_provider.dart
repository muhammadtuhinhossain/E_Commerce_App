
import 'package:flutter/material.dart';

import '../../../../core/service/network_caller.dart';
import '../../../app/get_network_caller.dart';
import '../../../app/providers/auth_controller.dart';
import '../../../app/urls.dart';
import '../../data/models/sign_In_params.dart';
import '../../data/models/user_model.dart';


class SignInProvider extends ChangeNotifier{
  bool _signInProgress = false;

  bool get signInProgress => _signInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn(SignInParams params)async{
    bool isSuccess = false;
    _signInProgress = true;
    notifyListeners();
    
    final NetworkResponse response = await getNetWorkCaller().postRequest(Urls.signInUrl,
    body: params.toJson(),
      isFromLogin: true,
    );
    if(response.isSuccess){
      isSuccess = true;
      _errorMessage = null;

      String token = response.body['data']['token'];
      UserModel userModel = UserModel.fromJson(response.body['data']['user']);

      await AuthController.saveUserData(token, userModel);

    }else{
      _errorMessage = response.errorMessage;
    }
    _signInProgress = false;
    notifyListeners();
    return isSuccess;
  }
}