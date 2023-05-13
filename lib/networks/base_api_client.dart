import 'package:dio/dio.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';

class ApiErrorCodes {
  ApiErrorCodes._();
  static const int success = 200;
  static const int invalid = 600;
  static const int failure = 400;
}

class BaseApiClient {
  late final Dio _client = Dio(BaseOptions(baseUrl: ApiConstants.baseurl));

  Future<dynamic> getLoginCall(String url,String mobileNo,
      {String contenType = "application/json"}) async {
    try {
      var respone = await _client.get(url,
      queryParameters:  {"MOBILE_NO": mobileNo},
          options: Options(headers: {
            'Content-Type': contenType,
          }));
      return respone.data;
    } catch (e) {
      print(e);
    }
  }
   Future<dynamic> getCall(String url,
      {String contenType = "application/json"}) async {
    try {
      var respone = await _client.get(url,
          options: Options(headers: {
            'Content-Type': contenType,
          }));
      return respone.data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> postCall(String url,
      {dynamic request, String contenType = "application/json"}) async {
    try {
      var respone = await _client.post(url,
          options: Options(headers: {
            'Content-Type': contenType,
          }),
          data: request);
      return respone.data;
    } catch (e) {
      print(e);
    }
  }
}
