import 'package:flutter/material.dart';
import 'package:ghmcofficerslogin/networks/base_api_client.dart';
import 'package:ghmcofficerslogin/repository/login_repository.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/utils/utils.dart';

class LoginViewModel with ChangeNotifier {
  
  final _loginRepository = LoginRepository();
 

  getloginResponse(String mobileNo,BuildContext context) async {

   final result = await _loginRepository.getLoginApi(mobileNo);
 
    if (result.status == ApiErrorCodes.success) {
      Utils().flutterToast(result.message ?? "",false);
      if(result.mpin!.isEmpty){
      Navigator.pushNamed(context, AppRoutes.newmpin);

      }else if(result.otp!.isEmpty){
Navigator.pushNamed(context, AppRoutes.otpscreen);

      }
    } else if (result.status == ApiErrorCodes.failure) {
    
      Utils().flutterToast(result.message ?? "",true);
    } else {}
    notifyListeners();
  }

  
  

  

  

    
  
  }
