import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:ghmcofficerslogin/model/resend_otp_response.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';

class OTPView extends StatefulWidget {
  const OTPView({super.key});

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  var mobileno;
  var otpvalue;
  var otpApi;
  bool enableResend = false;
  int start = 30;
  Timer? countdownTimer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      startTimer();

      mobileno = await SharedPreferencesClass()
          .readTheData(PreferenceConstants.mobileno);
      otpApi =
          await SharedPreferencesClass().readTheData(PreferenceConstants.otp);
      print("otp from api ::: ${otpApi}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BgImage(imgPath: ImageConstants.bg),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black87, width: 1),
                  ),
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Text(
                          "Please type the verification code sent to ${mobileno}",
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        PinCodeFields(
                          obscureText: true,
                          length: 4,
                          fieldBorderStyle: FieldBorderStyle.square,
                          responsive: false,
                          fieldHeight: 50.0,
                          fieldWidth: 50.0,
                          borderWidth: 1.0,
                          activeBorderColor: Colors.white,
                          activeBackgroundColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0),
                          keyboardType: TextInputType.number,
                          autoHideKeyboard: false,
                          fieldBackgroundColor: Colors.black12,
                          borderColor: Colors.white,
                          textStyle: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          onComplete: (output) {
                            otpvalue = output;
                            print("otpvalue ::::${otpvalue}");
                          },
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (otpApi == otpvalue) {
                              Navigator.pushNamed(
                                  context, AppRoutes.set_mpin_view);
                            } else {
                              AlertWithOk.showAlertDialog(
                                  context, "Invalid OTP", onpressed: () {
                                Navigator.pop(context);
                              }, buttontext: TextConstants.ok);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 2.0,
                            backgroundColor: Color.fromARGB(255, 173, 48, 90),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child: Text(
                            TextConstants.validate,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        start == 0
                            ? Container()
                            : Text(
                                "Waiting for OTP : 00: $start",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                        start == 0
                            ? Column(
                                children: [
                                  Text(
                                    "Don't receive the code?",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      start = 10;
                                      startTimer();
                                      await InternetCheck()
                                          ? fetchDetails()
                                          : AlertsNetwork.showAlertDialog(
                                              context,
                                              TextConstants.internetcheck,
                                              onpressed: () {
                                              Navigator.pop(context);
                                            }, buttontext: TextConstants.ok,);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 2.0,
                                      backgroundColor:
                                          Color.fromARGB(255, 173, 48, 90),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                    child: Text(
                                      TextConstants.resend,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  fetchDetails() async {
    EasyLoading.show();
    final requestUrl = ApiConstants.baseurl + ApiConstants.resend_otp_endpoint;
    final requestPayload = {
      "userid": AppConstants.userid,
      "password": AppConstants.password,
      "mobile_no": mobileno
    };

    print("payload ::: ${requestPayload}");

    final _dioObject = Dio();
    try {
      final _response = await _dioObject.post(requestUrl, data: requestPayload);
      final data = ResendOtpModel.fromJson(_response.data);
      EasyLoading.dismiss();
      otpApi = data.otp;
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
  }

  startTimer() {
    const onsec = Duration(seconds: 1);
    countdownTimer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          countdownTimer!.cancel();
          enableResend = true;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }
}
