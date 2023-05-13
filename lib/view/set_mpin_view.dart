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

class SetMpinView extends StatefulWidget {
  SetMpinView({super.key});

  @override
  State<SetMpinView> createState() => _SetMpinViewState();
}

class _SetMpinViewState extends State<SetMpinView> {
  final TextEditingController _setmpin = TextEditingController();
  final TextEditingController _confirmmpin = TextEditingController();
  var mobileno;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      mobileno = await SharedPreferencesClass()
          .readTheData(PreferenceConstants.mobileno);
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black87, width: 1),
                  ),
                  color: Colors.transparent,
                  elevation: 8.0,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Center(
                      child: Column(
                        children: [
                          //pincode fields
                          Container(
                            child: Column(
                              children: [
                                //set 4 digit mpin
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Text(
                                    TextConstants.enter_mpin,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.0),
                                  ),
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
                                    _setmpin.text = output;
                                  },
                                ),

                                //confirm 4 digit mpin
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Text(TextConstants.confirm_mpin,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.0)),
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
                                    _confirmmpin.text = output;
                                  },
                                ),
                              ],
                            ),
                          ),
                          //validate button
                          ElevatedButton(
                            onPressed: () async {
                              await InternetCheck()
                                  ? await setMpin()
                                  : AlertsNetwork.showAlertDialog(
                                      context, TextConstants.internetcheck,
                                      onpressed: () {
                                      Navigator.pop(context);
                                    }, buttontext: TextConstants.ok);
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 2.0,
                              backgroundColor: Color.fromARGB(255, 173, 48, 90),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            child: Text(
                              TextConstants.set_mpin,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  setMpin() async {
    EasyLoading.show();
    final requestUrl = ApiConstants.baseurl + ApiConstants.update_mpin;
    print("set mpin url ::: ${requestUrl}");
    final _dioObject = Dio();

    try {
      final _response = await _dioObject.get(requestUrl,
          queryParameters: {"MOBILE_NO": mobileno, "mpin": _setmpin.text});
      print("set mpin response :: ${_response.data}");

      final data = UpdateMpinResponse.fromJson(_response.data);

      EasyLoading.dismiss();
      if (data != null) {
        if (data.status == true) {
          AlertWithOk.showAlertDialog(context, "${data.tag}", onpressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.newmpin);
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
