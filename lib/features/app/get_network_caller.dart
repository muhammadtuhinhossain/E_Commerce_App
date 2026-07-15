import 'package:crafty_bay/core/service/network_caller.dart';
import 'package:crafty_bay/features/app/providers/auth_controller.dart';

NetworkCaller getNetWorkCaller(){
  return NetworkCaller(
    headers: () => {
      'content-type': 'application/json',
      if(AuthController.accessToken != null)
      'token': AuthController.accessToken!,
    },
  );
}

// Uses

// NetworkResponse response = await getNetWorkCaller().getRequest('url');
// if(response.isSuccess){
//
// }else{
// response.errorMessage!;
// }