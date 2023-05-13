import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/model/update_mpin_response.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';

class Mpin extends StatefulWidget {
  const Mpin({super.key});

  @override
  State<Mpin> createState() => _MpinState();
}

class _MpinState extends State<Mpin> {
  StreamSubscription? connection;
  bool isoffline = false;
  String? mpinValue;
  var mobileno;
  var netResult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BgImage(imgPath: ImageConstants.bg),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black87, width: 1),
                  ),
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      PinCodeFields(
                        length: 4,
                        fieldBorderStyle: FieldBorderStyle.square,
                        responsive: false,
                        fieldHeight: 50.0,
                        fieldWidth: 50.0,
                        borderWidth: 1.0,
                        activeBorderColor: Colors.black,
                        activeBackgroundColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(10.0),
                        keyboardType: TextInputType.number,
                        autoHideKeyboard: false,
                        fieldBackgroundColor: Colors.black12,
                        borderColor: Colors.black38,
                        textStyle: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        onComplete: (output) {
                          mpinValue = output;
                        },
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          var res = await SharedPreferencesClass()
                              .readTheData(PreferenceConstants.mpin);
                          var des = await SharedPreferencesClass()
                              .readTheData(PreferenceConstants.designation);
                          var roleId = await SharedPreferencesClass()
                              .readTheData(PreferenceConstants.roleId);
                          print("mpin---${res}  ");
                          print("enters mpin ${mpinValue}");
                          if (res == mpinValue) {
                            if (roleId == "33") {
                              Navigator.pushNamed(
                                  context, AppRoutes.corporatordashboard);
                              print("roleid ${roleId}");
                              mpinValue = '';
                            } else {
                              if (des == "Concessionaire Incharge") {
                                Navigator.pushNamed(
                                    context, AppRoutes.concessionairedashboard);
                                print("desconce ${des}");
                                mpinValue = '';
                              } else if (des == "Plant Assistant") {
                                Navigator.pushNamed(
                                    context, AppRoutes.plantdashnoard);
                                mpinValue = '';
                                print("desplant ${des}");
                              } else {
                                Navigator.pushNamed(
                                    context, AppRoutes.ghmcdashboard);
                                print("desghmc ${des}");
                                mpinValue = '';
                              }
                            }
                          } else {
                            AlertWithOk.showAlertDialog(
                                context, TextConstants.invalid_mpin,
                                onpressed: () {
                              Navigator.pop(context);
                            }, buttontext: TextConstants.ok);
                            mpinValue = '';
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 5.0,
                          backgroundColor: Color.fromARGB(255, 173, 48, 90),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        child: Text(
                          TextConstants.login,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            await InternetCheck()
                                ? await setMpin()
                                : AlertsNetwork.showAlertDialog(
                                    context, TextConstants.internetcheck,
                                    onpressed: () {
                                    Navigator.pop(context);
                                  }, buttontext: TextConstants.ok);
                          },
                          child: const Text(
                            TextConstants.reset_mpin,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              decoration: TextDecoration.underline,
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      mobileno = await SharedPreferencesClass()
          .readTheData(PreferenceConstants.mobileno);
    });
  }

  setMpin() async {
    EasyLoading.show();
    final requestUrl = ApiConstants.baseurl + ApiConstants.update_mpin;
    final _dioObject = Dio();

    try {
      final _response = await _dioObject.get(requestUrl,
          queryParameters: {"MOBILE_NO": mobileno, "mpin": "0000"});

      final data = UpdateMpinResponse.fromJson(_response.data);
      print(_response.data);
      EasyLoading.dismiss();
      if (data != null) {
        if (data.status == true) {
          AlertWithOk.showAlertDialog(context, "${data.tag}", onpressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.myloginpage);
          }, buttontext: "OK", buttontextcolor: Colors.teal);
        } else {
          AlertWithOk.showAlertDialog(context, "${data.tag}", onpressed: () {
            Navigator.pop(context);
          }, buttontext: "OK", buttontextcolor: Colors.teal);
        }
      }
    } on DioError catch (e) {
      EasyLoading.dismiss();
      return showDialog(
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
}
