import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghmcofficerslogin/model/plant_operator/get_weighbridge_details_responnse.dart';
import 'package:ghmcofficerslogin/model/plant_operator/get_weigh_bridge_details_req.dart';
import 'package:ghmcofficerslogin/model/plant_operator/plant_operator_submit_req.dart';
import 'package:ghmcofficerslogin/model/plant_operator/plant_operator_submit_response.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/button.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/components/textwidget.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/cnd_api_constant.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';
import 'package:ghmcofficerslogin/utils/device_id.dart';
import 'package:ghmcofficerslogin/utils/utils.dart';

class VehicleTripDetails extends StatefulWidget {
  const VehicleTripDetails({super.key});

  @override
  State<VehicleTripDetails> createState() => _VehicleTripDetailsState();
}

class _VehicleTripDetailsState extends State<VehicleTripDetails> {
  TextEditingController transactionNoController = TextEditingController();
  TextEditingController grossWtController = TextEditingController(text: "200");
  TextEditingController tareWtController = TextEditingController(text: "100");
  TextEditingController netWtController = TextEditingController(text: "34444");

  WeighBridgeDetailsResponse? _weighBridgeDetailsResponse;
  //PlantOperatorSubmitResponse? _plantOperatorSubmitResponse;
  FocusNode myFocusNode = new FocusNode();
  bool flag = false, readvalue = false;
  String? grossWt = "", tareWt = "", netwt = "";
  String? deviceId;
  @override
  void initState() {
    super.initState();
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async { 
     deviceId = await generateDeviceId();
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.black),
            onPressed: () async {
              Navigator.pushNamed(context, AppRoutes.plantdashnoard);
              ;
            },
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: (() {
              Navigator.of(context).pop();
            })
            //() => Navigator.of(context).pop(),
            ),
        title: Center(
          child: Text(
            "Vehicle Trip Details",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(children: <Widget>[
        BgImage(imgPath: ImageConstants.bg),
        SingleChildScrollView(
          child: Column(
            children: [
              RowComponent(TextConstants.ticketID,
                  AppConstants.vehicleRes?.cNDWGRIEVANCESID),
              RowComponent(TextConstants.datetime,
                  AppConstants.vehicleRes?.tICKETUPDATEDON),
              RowComponent(TextConstants.VehicleNo,
                  AppConstants.vehicleRes?.vEHICLENUMBER),
              RowComponent(TextConstants.zone, AppConstants.vehicleRes?.zONE),
              RowComponent(
                  TextConstants.circle, AppConstants.vehicleRes?.cIRCLE),
              RowComponent(TextConstants.ward, AppConstants.vehicleRes?.wARD),
              RowComponent(TextConstants.driverName,
                  AppConstants.vehicleRes?.dRIVERNAME),
              TextFormField(
                focusNode: myFocusNode,
                controller: transactionNoController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                maxLength: 10,
                readOnly: readvalue,
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
                          : Colors.white,
                      fontSize: 14.0),
                  labelText: TextConstants.tranNo,
                ),
              ),
              if (flag == false) ...[
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Card(
                    color: Colors.transparent,
                    child: textButton(
                        text: TextConstants.getDetails,
                        textcolor: Colors.white,
                        onPressed: () {
                          if (transactionNoController.text.isEmpty) {
                            Utils().flutterToast(
                                TextConstants.please_enter_tranNo, true);
                          } else {
                            setState(() async {
                              flag = true;
                              readvalue = true;
                              await InternetCheck()
                                  ? getWeighBridgeDetailsMethod()
                                  : AlertsNetwork.showAlertDialog(
                                      context, TextConstants.internetcheck,
                                      onpressed: () {
                                      Navigator.pop(context);
                                    }, buttontext: TextConstants.ok);
                            });
                          }
                        }),
                  ),
                ),
              ] else ...[
                TextFormField(
                  focusNode: myFocusNode,
                  controller: grossWtController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  readOnly: true,
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
                            : Colors.white,
                        fontSize: 14.0),
                    labelText: TextConstants.grossWt,
                  ),
                ),
                TextFormField(
                  focusNode: myFocusNode,
                  controller: tareWtController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  readOnly: true,
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
                            : Colors.white,
                        fontSize: 14.0),
                    labelText: TextConstants.tareWt,
                  ),
                ),
                TextFormField(
                  focusNode: myFocusNode,
                  controller: netWtController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  readOnly: true,
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
                            : Colors.white,
                        fontSize: 14.0),
                    labelText: TextConstants.netWt,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Card(
                    color: Colors.transparent,
                    child: textButton(
                        text: TextConstants.submit,
                        textcolor: Colors.white,
                        onPressed: () async {
                          await InternetCheck()
                              ? getWeighBridgeSubmit()
                              : AlertsNetwork.showAlertDialog(
                                  context, TextConstants.internetcheck,
                                  onpressed: () {
                                  Navigator.pop(context);
                                }, buttontext: TextConstants.ok);
                        }),
                  ),
                ),
              ]
            ],
          ),
        )
      ]),
    );
  }

  ///
  ///class ConcessionairePickupCapture extends StatefulWidget {

  RowComponent(var data, var val) {
    //final void Function()? onpressed;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 1,
              //Text("${data}",style: TextStyle(decoration: TextDecoration.underline),)
              child: TextWidget(
                text: "${data}",
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                textcolor: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          Expanded(
              flex: 2,
              child: TextWidget(
                text: "${val}",
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                textcolor: Colors.white,
              ))
        ],
      ),
    );
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.transparent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  validate(String remarks) {
    if (remarks == "Select Vehicle No") {
      print(remarks);
      return true;
    } else if (remarks == "Select Plant Name") {
      print(remarks);
      return true;
    } else if (remarks == '') {
      return true;
    } else if (remarks.length < 10) {
      print("remarks :$remarks");
      return true;
    } else if (remarks == "Select Vehicle Type") {
      return true;
    } else {
      return false;
    }
  }

  void getWeighBridgeDetailsMethod() async {
    var token =
        await SharedPreferencesClass().readTheData(PreferenceConstants.tokenId);
    final url =
        CndApiConstants.cndbaseurl + CndApiConstants.getweighBridgeDetails;
    WeighBridgeDetailsReq weighBridgeReq = new WeighBridgeDetailsReq();
    weighBridgeReq.tRANSACTIONNO = transactionNoController.text;
    weighBridgeReq.vEHICLENO = AppConstants.vehicleRes?.vEHICLENUMBER;
    weighBridgeReq.tICKETID = AppConstants.vehicleRes?.cNDWGRIEVANCESID;
    weighBridgeReq.tOKENID = token;
    final payload = weighBridgeReq.toJson();
    final _dioOnject = Dio();
    final response = await _dioOnject.post(url, data: payload);

    final data = WeighBridgeDetailsResponse.fromJson(response.data);
    EasyLoading.dismiss();
    try {
      if (data.sTATUSCODE == "200") {
        setState(() {
          _weighBridgeDetailsResponse = data;
          if (data != null) {
            grossWt = _weighBridgeDetailsResponse?.gROSSWeight;
            tareWt = _weighBridgeDetailsResponse?.tareWeight;
            netwt = _weighBridgeDetailsResponse?.netWeight;
          }
        });
      } else if (data.sTATUSCODE == "400") {
        setState(() {
          _weighBridgeDetailsResponse = data;
        });
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return SingleButtonDialogBox(
                bgColor: Color.fromARGB(255, 225, 38, 38),
                descriptions: "${data.sTATUSMESSAGE}",
                img: Image.asset(ImageConstants.cross),
                onPressed: () {
                  Navigator.pop(context);
                });
          },
        );
      } else if (data.sTATUSCODE == "600") {
        setState(() {
          _weighBridgeDetailsResponse = data;
        });
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  bgColor: Color.fromARGB(255, 225, 38, 38),
                  descriptions: "${data.sTATUSMESSAGE}",
                  img: Image.asset(ImageConstants.cross),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.myloginpage);
                  });
            });
      }
    } on DioError catch (e) {
      EasyLoading.dismiss();
      return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SingleButtonDialogBox(
              bgColor: Color.fromARGB(255, 225, 38, 38),
              descriptions: "Network is busy please try again",
              img: Image.asset(ImageConstants.cross),
              onPressed: () {
                Navigator.pop(context);
              });
        },
      );
    }
  }

  void getWeighBridgeSubmit() async {
    EasyLoading.show();
    var token =
        await SharedPreferencesClass().readTheData(PreferenceConstants.tokenId);
    var empId =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
    final url = CndApiConstants.cndbaseurl + CndApiConstants.getOperatorsubmit;
    PlantOperatorSubmitReq plantOperatorSubmitReq =
        new PlantOperatorSubmitReq();
    plantOperatorSubmitReq.cNDWGRIEVANCEID = transactionNoController.text;
    plantOperatorSubmitReq.eMPLOYEEID = empId;
    plantOperatorSubmitReq.dEVICEID = deviceId;
    plantOperatorSubmitReq.tOKENID = token;
    plantOperatorSubmitReq.vEHICLENUMBER =
        AppConstants.vehicleRes?.vEHICLENUMBER;
    plantOperatorSubmitReq.gROSSWT = grossWtController.text;
    plantOperatorSubmitReq.tAREWT = tareWtController.text;
    plantOperatorSubmitReq.nETWT = netWtController.text;
    final payload = plantOperatorSubmitReq.toJson();
    final _dioOnject = Dio();
    final response = await _dioOnject.post(url, data: payload);

    final data = PlantOperatorSubmitResponse.fromJson(response.data);
    EasyLoading.dismiss();
    try {
      if (data.sTATUSCODE == "200") {
        setState(() {
          data;
        });
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return SingleButtonDialogBox(
                bgColor: Color.fromARGB(255, 56, 197, 56),
                descriptions: "${data.sTATUSMESSAGE}",
                img: Image.asset(ImageConstants.check),
                onPressed: () {
                  Navigator.pop(context);
                });
          },
        );
      } else if (data.sTATUSCODE == "400") {
        setState(() {
          data;
        });
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return SingleButtonDialogBox(
                bgColor: Color.fromARGB(255, 225, 38, 38),
                descriptions: "${data.sTATUSMESSAGE}",
                img: Image.asset(ImageConstants.cross),
                onPressed: () {
                  Navigator.pop(context);
                });
          },
        );
      } else if (data.sTATUSCODE == "600") {
        setState(() {
          data;
        });
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return SingleButtonDialogBox(
                bgColor: Color.fromARGB(255, 225, 38, 38),
                descriptions: "${data.sTATUSMESSAGE}",
                img: Image.asset(ImageConstants.cross),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.myloginpage);
                });
          },
        );
      }
    } on DioError catch (e) {
      EasyLoading.dismiss();
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SingleButtonDialogBox(
              bgColor: Color.fromARGB(255, 225, 38, 38),
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
