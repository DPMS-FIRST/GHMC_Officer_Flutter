import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmcofficerslogin/model/login_response.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  StreamSubscription? connection;
  bool isoffline = false;

  TextEditingController number = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode = new FocusNode();

  ghmc_login? ResponseData;
  String otpValue = '';
  String? mpin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  color: Colors.transparent,
                  child: SizedBox(
                    height: 200.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textInputAction: TextInputAction.done,
                              focusNode: myFocusNode,
                              controller: number,
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              cursorColor: Color.fromARGB(255, 33, 184, 166),
                              decoration: InputDecoration(
                                //to hide maxlength
                                counterText: '',
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 33, 184, 166),
                                )),

                                labelStyle: TextStyle(
                                    color: myFocusNode.hasFocus
                                        ? Color.fromARGB(255, 33, 184, 166)
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                                labelText: TextConstants.mobile_no,
                              ),
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return TextConstants.mobile_validation;
                                } else if (value.length < 10) {
                                  return TextConstants.mobile_count_validation;
                                }
                                return null;
                              }),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await InternetCheck()
                                      ? fetchLoginDetailsFromApi()
                                      : AlertsNetwork.showAlertDialog(
                                          context, TextConstants.internetcheck,
                                          onpressed: () {
                                          Navigator.pop(context);
                                        }, buttontext: TextConstants.ok);
                                }
                              },
                              child: Text(
                                TextConstants.login,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink[400],
                                textStyle: TextStyle(fontSize: 16),
                                //minimumSize: Size.fromHeight(55),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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
  }

  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  void fetchLoginDetailsFromApi() async {
    EasyLoading.show();
    final requestUrl = ApiConstants.baseurl + ApiConstants.login_endpoint;

    print("login url :: ${requestUrl}");

    final _dioObject = Dio();

    //Response
    try {
      final _response = await _dioObject
          .get(requestUrl, queryParameters: {"MOBILE_NO": number.text});
      print("login response ::: ${_response.data}");
      final data = ghmc_login.fromJson(_response.data);
      ResponseData = data;
      EasyLoading.dismiss();
      if (_response.data != null) {
        if (ResponseData?.status == 'M') {
          print("checking ${ResponseData?.mpin.runtimeType}");
          if (ResponseData?.mpin != null) {
            await SharedPreferencesClass()
                .writeTheData(PreferenceConstants.mpin, ResponseData?.mpin);
          }
          if (ResponseData?.mOBILENO != null) {
            await SharedPreferencesClass().writeTheData(
                PreferenceConstants.mobileno, ResponseData?.mOBILENO);
          }
          if (ResponseData?.dESIGNATION != null) {
            await SharedPreferencesClass().writeTheData(
                PreferenceConstants.designation, ResponseData?.dESIGNATION);
          }
          if (ResponseData?.eMPD != null) {
            await SharedPreferencesClass()
                .writeTheData(PreferenceConstants.empd, ResponseData?.eMPD);
          }
          if (ResponseData?.eMPNAME != null) {
            await SharedPreferencesClass()
                .writeTheData(PreferenceConstants.name, ResponseData?.eMPNAME);
          }
          if (ResponseData?.message != null) {
            await SharedPreferencesClass().writeTheData(
                PreferenceConstants.message, ResponseData?.message);
          }
          if (ResponseData?.status != null) {
            await SharedPreferencesClass()
                .writeTheData(PreferenceConstants.status, ResponseData?.status);
          }
          if (ResponseData?.tOKENID != null) {
            await SharedPreferencesClass().writeTheData(
                PreferenceConstants.tokenId, ResponseData?.tOKENID);
          }
          if (ResponseData?.tYPEID != null) {
            await SharedPreferencesClass()
                .writeTheData(PreferenceConstants.typeid, ResponseData?.tYPEID);
          }
          if (ResponseData?.roleId != null) {
            await SharedPreferencesClass()
                .writeTheData(PreferenceConstants.roleId, ResponseData?.roleId);
          }
          if (ResponseData?.ward != null) {
            await SharedPreferencesClass()
                .writeTheData(PreferenceConstants.ward, ResponseData?.ward);
          }
          Navigator.pushNamed(context, AppRoutes.newmpin);
        } else if (ResponseData?.status == 'O') {
          SharedPreferencesClass().writeTheData(
              PreferenceConstants.mobileno, ResponseData?.mOBILENO);
          print("otp from Api ${ResponseData?.otp}");
          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.otp, ResponseData?.otp);
          SharedPreferencesClass().writeTheData(
              PreferenceConstants.category, ResponseData?.cATEGORY);
          SharedPreferencesClass().writeTheData(
              PreferenceConstants.designation, ResponseData?.dESIGNATION);
          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.empd, ResponseData?.eMPD);
          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.name, ResponseData?.eMPNAME);
          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.message, ResponseData?.message);
          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.status, ResponseData?.status);
          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.tokenId, ResponseData?.tOKENID);
          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.typeid, ResponseData?.tYPEID);

          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.roleId, ResponseData?.roleId);

          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.ward, ResponseData?.ward);

          print(ResponseData?.eMPNAME);
          Navigator.pushNamed(context, AppRoutes.otpView);
        } else if (ResponseData?.status == 'N') {
          AlertWithOk.showAlertDialog(context, "${ResponseData?.message}",
              onpressed: () {
            Navigator.pop(context);
          }, buttontext: TextConstants.ok);
        }
      } else {
        AlertWithOk.showAlertDialog(context, "${ResponseData?.message}",
            onpressed: () {
          Navigator.pop(context);
        }, buttontext: TextConstants.ok);
      }
    } on DioError catch (e) {
      EasyLoading.dismiss();
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 500 ||
          e.response?.statusCode == 404) {
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
  }
}
