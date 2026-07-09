import 'package:crafty_bay/core/service/network_caller.dart';

NetworkCaller getNetWorkCaller(){
  return NetworkCaller(
    headers: () => {
      'content-type': 'application/json',
      // 'access-token': 'token',
    }
  );
}

// Uses

// NetworkResponse response = await getNetWorkCaller().getRequest('url');
// if(response.isSuccess){
//
// }else{
// response.errorMessage!;
// }