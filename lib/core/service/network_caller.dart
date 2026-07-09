import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';

part 'network_response.dart';

class NetworkCaller {

  final Logger _logger= Logger();

  final Map<String, String>Function() headers;
  NetworkCaller({required this.headers});

  //Get
  Future<NetworkResponse> getRequest(String url)async{

    try {
      Uri uri = Uri.parse(url);

      _logRequest(url);

      final Response response = await get(uri);

      _logResponse(response);

      if(response.statusCode == 200){
        //success
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(isSuccess: true, statusCode: response.statusCode, body: decodedJson);
      }else{
        //failed
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            body: decodedJson,
            errorMessage: decodedJson['msg']?? 'Something went wrong',
        );
      }
    } on Exception catch (e) {
     return NetworkResponse(isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }
  //Post

  Future<NetworkResponse> postRequest(String url, {Map<String, dynamic>?body})async{

    try {
      Uri uri = Uri.parse(url);

      _logRequest(url, requestBody: body, headers: headers());

      final Response response = await post(uri, headers: headers(), body: jsonEncode(body),);

      _logResponse(response);

      if(response.statusCode == 200 || response.statusCode == 201){
        //success
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(isSuccess: true, statusCode: response.statusCode, body: decodedJson);
      }else{
        //failed
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          body: decodedJson,
          errorMessage: decodedJson['msg']?? 'Something went wrong',
        );
      }
    } on Exception catch (e) {
      return NetworkResponse(isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  // Logger
  void _logRequest(String url, {Map<String, dynamic>? requestBody, Map<String, String>? headers}){
    _logger.d('''URL =>  $url
    Headers => $headers
    RequestBody => $requestBody
    ''');
  }
  void _logResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      _logger.i('''URL=> ${response.request?.url}
    Status Code => ${response.statusCode}
    RequestBody => ${response.body}
    ''');
    }else{
      _logger.e('''URL => ${response.request?.url}
      Status Code => ${response.statusCode}
      RequestBody => ${response.body}
      ''');
    }
  }
}