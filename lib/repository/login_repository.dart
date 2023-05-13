import 'package:ghmcofficerslogin/networks/base_api_client.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';

import '../model/login_response_model.dart';

class LoginRepository {
  final _baseClient = BaseApiClient();
  Future<LoginResponse> getLoginApi(String MobileNo) async {
    final response= await _baseClient.getLoginCall(ApiConstants.login_endpoint,MobileNo);
    return LoginResponse.fromJson(response);
  }

}
