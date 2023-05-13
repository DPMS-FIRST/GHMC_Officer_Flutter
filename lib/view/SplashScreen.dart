import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/model/splash_versioncheck_model.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';
import 'package:ghmcofficerslogin/utils/app_info.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  var mpin;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      mpin =
          await SharedPreferencesClass().readTheData(PreferenceConstants.mpin);
      Timer(
          const Duration(seconds: 2),
          () async => await InternetCheck()
              ? VersoinChecking()
              : AlertsNetwork.showAlertDialog(
                  context, TextConstants.internetcheck, onpressed: () {
                  Navigator.pop(context);
                }, buttontext: TextConstants.ok));
      print("mpin :: ${mpin}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/splashscreenghmc.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  VersoinChecking() async {
    EasyLoading.show();
    //step1: create request url with base url and endpoint
    const requestUrl = ApiConstants.baseurl + ApiConstants.splash_endpoint;

//step 2: create payload if request post ,put,option
    final requestPayload = {
      "userid": AppConstants.userid,
      "password": AppConstants.password
    };

// step 3: create headders and autherazation
    // Map<String, String> requestHeaders = {'Content-Type': 'application/json; charset=UTF-8', 'Access-Control-Allow-Origin': '*'};
// step 4: dio or http use this package connect to server
    final _dioObject = Dio();

    try {
      final _response = await _dioObject.post(requestUrl, data: requestPayload);
      //convet this response from json to modelclass

      print(_response.data);
      final splashResopnse = VersionCheck.fromJson(_response.data);
      EasyLoading.dismiss();
      if (splashResopnse.status == true) {
        var versionNumber = await appVersion().getAppVersion();
        print("app version::::: ${versionNumber}");
        print("api version ::: ${splashResopnse.tag}");
        if (splashResopnse.tag != null &&
            versionNumber == "${splashResopnse.tag}.0") {
          print("app mpin::::: ${mpin}");
          SharedPreferencesClass().writeTheData(
              PreferenceConstants.versionNumber, splashResopnse.tag);
          if (mpin != null && mpin != '') {
            Navigator.pushReplacementNamed(context, AppRoutes.newmpin);
          } else {
            Navigator.pushReplacementNamed(context, AppRoutes.myloginpage);
          }
        }
      } else {
        return showDialog(
          context: context,
          builder: (context) {
            return SingleButtonDialogBox(
                bgColor: Color.fromARGB(255, 202, 58, 58),
                descriptions: "${splashResopnse.message}",
                img: Image.asset(ImageConstants.cross,
                    color: Color.fromARGB(255, 202, 58, 58)),
                onPressed: () {
                  Navigator.pop(context);
                });
          },
        );
      }
    } on DioError catch (e) {
      EasyLoading.dismiss();
        return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return SingleButtonDialogBox(
                bgColor: Color.fromARGB(255, 202, 58, 58),
                descriptions: "Network is busy please try again",
                img: Image.asset(ImageConstants.cross),
                onPressed: () {
                  Navigator.pop(context);
                });
          },
        );
    }
// step 5: print the response
  }
}
