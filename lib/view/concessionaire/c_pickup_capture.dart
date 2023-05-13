import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghmcofficerslogin/model/concessioner/c_pickup_capture_submit_res.dart';
import 'package:ghmcofficerslogin/model/concessioner/concessionaire_pickup_capture_bind_plantname_req.dart';
import 'package:ghmcofficerslogin/model/concessioner/concessionaire_pickup_capture_bindplantname_res.dart';
import 'package:ghmcofficerslogin/model/concessioner/conecssionare_pickup_capture_get_vehicletypes_res.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/button.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/showalert.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showtoast.dart';
import 'package:ghmcofficerslogin/res/components/textwidget.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/providers/provider_notifiers.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/utils/device_id.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';

import '../../res/components/sharedpreference.dart';
import '../../res/constants/text_constants/text_constants.dart';

class ConcessionairePickupCapture extends StatefulWidget {
  const ConcessionairePickupCapture({super.key});

  @override
  State<ConcessionairePickupCapture> createState() =>
      _ConcessionairePickupCaptureState();
}

class _ConcessionairePickupCaptureState
    extends State<ConcessionairePickupCapture> {
  ConcessionairePickupCaptureBindPlantNameRes?
      _concessionairePickupCaptureBindPlantNameRes;

  CPickupCaptureSubmitRes? _cPickupCaptureSubmitRes;

  ConcessionairePickupCaptureGetVehicleTypesRes?
      _concessionairePickupCaptureGetVehicleTypesRes;
  TextEditingController drivername = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  bool submit_yes = false;
  bool submit_no = false;
  String is_yes_flag = "";
  String vehicletypeid = "";
  String plantid = "";
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode1 = new FocusNode();
  FocusNode myFocusNode2 = new FocusNode();
  List vehicleNo = ["Select Vehicle No"];
  List plantnames = ["Select Plant Name"];
  List vehicletypes = ["Select Vehicle Type"];
  Map vehciledata = {};
  Map plantdata = {};

  File? _image;
  File? _image2;
  String? deviceId;
  StreamSubscription? connection;
  bool isoffline = false;
  Future getImage(ImageSource type) async {
    final img = await ImagePicker().pickImage(source: type);
    if (img == null) return;
    final tempimg = File(img.path);
    setState(() {
      this._image = tempimg;
    });
  }

  Future getImage2(ImageSource type) async {
    final img = await ImagePicker().pickImage(source: type);
    if (img == null) return;
    final tempimg = File(img.path);
    setState(() {
      this._image2 = tempimg;
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
              // EasyLoading.show();
              Navigator.pushNamed(context, AppRoutes.ghmcdashboard);
            },
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: (() {
              Navigator.of(context).pop();
              vehicleNumbersDropdown.value = "Select Vehicle No";
              vehicletypesdropdown.value = "Select Vehicle Type";
              bindplantnamesdropdown.value = "Select Plant Name";
            })
            //() => Navigator.of(context).pop(),
            ),
        title: Center(
          child: Text(
            "Concessionaire Pickup Capture",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ),
      body: Stack(children: <Widget>[
        BgImage(imgPath: ImageConstants.bg),
        SingleChildScrollView(
          child: Column(
            children: [
              RowComponent(
                  TextConstants.concessionaire_pickup_capturelist_ticketID,
                  AppConstants.ticktetitemslist?.tICKETID),
              RowComponent(
                  TextConstants.concessionaire_pickup_capturelist_locatio,
                  AppConstants.ticktetitemslist?.lOCATION),
              RowComponent(
                  TextConstants.concessionaire_pickup_capturelist_Landmark,
                  AppConstants.ticktetitemslist?.lANDMARK),
              RowComponent(TextConstants.concessionaire_pickup_capturelist_date,
                  AppConstants.ticktetitemslist?.cREATEDDATE),
              ValueListenableBuilder(
                valueListenable: vehicleNumbersDropdown,
                builder: (context, value, child) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 20),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: DropdownButton(
                            underline: Container(color: Colors.transparent),
                            hint: value == null
                                ? Text('Please Select ')
                                : Text(
                                    value,
                                    style: TextStyle(color: Colors.white),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            dropdownColor: Colors.white,
                            iconEnabledColor: Colors.white,
                            style: TextStyle(color: Colors.black),
                            items: vehicleNo.map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text("$val"),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              print(" $val");
                              vehicleNumbersDropdown.value = "$val";
                            }),
                      ),
                    ),
                  );
                },
              ),
              RowComponent(
                  TextConstants.concessionaire_pickup_capture_beforepickup, ""),
              _image != null
                  ? GestureDetector(
                      onTap: (() {
                        ImageOptionAlert("Add Photo");
                      }),
                      child: Image.file(
                        _image!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blue,
                        ),
                        child: IconButton(
                          onPressed: (() {
                            ImageOptionAlert("Add Photo");
                          }),
                          icon: Icon(Icons.camera_alt_outlined),
                          color: Colors.white,
                        ),
                      ),
                    ),
              submit_yes
                  ? Column(
                      children: [
                        RowComponent(
                            TextConstants
                                .concessionaire_pickup_capture_after_pickup,
                            ""),
                        _image2 != null
                            ? GestureDetector(
                                onTap: (() {
                                  ImageOptionAlert2("Add Photo");
                                }),
                                child: Image.file(
                                  _image2!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.blue,
                                  ),
                                  child: IconButton(
                                    onPressed: (() {
                                      ImageOptionAlert2("Add Photo");
                                    }),
                                    icon: Icon(Icons.camera_alt_outlined),
                                    color: Colors.white,
                                  ),
                                ),
                              )
                      ],
                    )
                  : Text(""),
              ValueListenableBuilder(
                valueListenable: bindplantnamesdropdown,
                builder: (context, value, child) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 20),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: DropdownButton(
                            underline: Container(color: Colors.transparent),
                            hint: value == null
                                ? Text('Please Select ')
                                : Text(
                                    value,
                                    style: TextStyle(color: Colors.white),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            dropdownColor: Colors.white,
                            iconEnabledColor: Colors.white,
                            style: TextStyle(color: Colors.black),
                            items: plantdata.keys.toList().map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text("$val"),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              print(" $val");
                              bindplantnamesdropdown.value = "$val";
                              plantid = plantdata[val];
                              print("on dropdown ${plantid}");
                            }),
                      ),
                    ),
                  );
                },
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      TextFormField(
                        focusNode: myFocusNode1,
                        controller: drivername,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.text,
                        cursorColor: Color.fromARGB(255, 33, 184, 166),
                        decoration: InputDecoration(
                          //to hide maxlength

                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color.fromARGB(255, 33, 184, 166),
                          )),

                          labelStyle: TextStyle(
                              color: myFocusNode1.hasFocus
                                  ? Color.fromARGB(255, 33, 184, 166)
                                  : Colors.white,
                              fontSize: 18.0),
                          labelText: TextConstants
                              .concessionaire_pickup_capture_drivername,
                        ),
                      ),
                      TextFormField(
                        focusNode: myFocusNode2,
                        controller: mobilenumber,
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
                              color: myFocusNode2.hasFocus
                                  ? Color.fromARGB(255, 33, 184, 166)
                                  : Colors.white,
                              fontSize: 18.0),
                          labelText: TextConstants
                              .concessionaire_pickup_capture_mobileno,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: ValueListenableBuilder(
                  valueListenable: vehicletypesdropdown,
                  builder: (context, value, child) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0, bottom: 20),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.95,
                          decoration: BoxDecoration(color: Colors.white),
                          child: DropdownButton(
                              underline: Container(color: Colors.transparent),
                              hint: value == null
                                  ? Text('Please Select ')
                                  : Text(
                                      value,
                                      style: TextStyle(color: Colors.black),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              dropdownColor: Colors.white,
                              iconEnabledColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              items: vehciledata.keys.toList().map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text("$val"),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                print(" $val");
                                vehicletypesdropdown.value = "$val";
                                vehicletypeid = vehciledata[val];
                                print("in dropdown ${vehicletypeid}");
                              }),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Card(
                  color: Colors.transparent,
                  child: textButton(
                    text: TextConstants.concessionaire_pickup_capture_submit,
                    textcolor: Colors.white,
                    onPressed: () async {
                      if (vehicleNumbersDropdown.value == "Select Vehicle No") {
                        ShowToats.showToast("Please select vehicle no");
                      } else if (_image?.path == null) {
                        ShowToats.showToast("Please select image ");
                      } else if (bindplantnamesdropdown.value ==
                          "Select Plant Name") {
                        ShowToats.showToast("Please select plant name");
                      } else if (drivername.text.isEmpty) {
                        ShowToats.showToast("Please enter driver name");
                      } else if (mobilenumber.text.isEmpty ||
                          mobilenumber.text.length < 10) {
                        ShowToats.showToast(
                            "Please enter 10 digit mobile number");
                      } else if (!mobilenumber.text.startsWith("9") &&
                          !mobilenumber.text.startsWith("8") &&
                          !mobilenumber.text.startsWith("7")) {
                        ShowToats.showToast(
                            "Please enter  mobile number starts with 9 or 8 or 7");
                      } else if (vehicletypesdropdown.value ==
                          "Select Vehicle Type") {
                        ShowToats.showToast("Please select vehicle type");
                      } else if (submit_yes) {
                        if (_image2?.path == null) {
                          ShowToats.showToast("Please select after trip image");
                        } else {
                          submit_yes
                              ? Alerts.showAlertDialog(context,
                                  _cPickupCaptureSubmitRes?.sTATUSMESSAGE,
                                  Title: "GHMC Officer App", onpressed: (() {
                                  Navigator.popUntil(
                                      context,
                                      ModalRoute.withName(
                                          AppRoutes.concessionairedashboard));
                                  vehicleNumbersDropdown.value =
                                      "Select Vehicle No";
                                  vehicletypesdropdown.value =
                                      "Select Vehicle Type";
                                  bindplantnamesdropdown.value =
                                      "Select Plant Name";
                                }), buttontext: 'ok')
                              : null;
                        }
                      } else {
                        showSubmitAlert(TextConstants
                            .concessionaire_pickup_capture_is_this_your_last_trip);
                        submit_no
                            ? Alerts.showAlertDialog(context,
                                _cPickupCaptureSubmitRes?.sTATUSMESSAGE,
                                Title: "GHMC Officer App", onpressed: (() {
                                Navigator.popUntil(
                                    context,
                                    ModalRoute.withName(
                                        AppRoutes.concessionairedashboard));
                                vehicleNumbersDropdown.value =
                                    "Select Vehicle No";
                                vehicletypesdropdown.value =
                                    "Select Vehicle Type";
                                bindplantnamesdropdown.value =
                                    "Select Plant Name";
                              }), buttontext: 'ok')
                            // ? onSubmitNo(
                            //     "${_cPickupCaptureSubmitRes?.sTATUSMESSAGE}")
                            : null;
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  RowComponent(var data, var val) {
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

  ImageOptionAlert(String message, {String text = ""}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Center(
              child: TextWidget(
                text: message + text,
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                fontsize: 15,
                textcolor: Colors.black,
              ),
            ),

            // title: Text(message + text),
            actions: [
              ValueListenableBuilder(
                valueListenable: imageOptions,
                builder: (context, value, child) {
                  return RadioGroup<String>.builder(
                    textStyle: TextStyle(color: Colors.black),
                    groupValue: value ?? "",
                    onChanged: (value) {
                      imageOptions.value = value;
                      if (value == "Choose from Library") {
                        getImage(ImageSource.gallery);
                      } else if (value == "Take Photo") {
                        getImage(ImageSource.camera);
                      } else if (value == "cancel") {}

                      Navigator.pop(context);
                      imageOptions.value = null;
                    },
                    items: AppConstants.imagePickingOptions,
                    itemBuilder: (item) => RadioButtonBuilder(
                      item,
                    ),
                  );
                },
              ),
            ],
          );
        });
    //showDialog
  }

  ImageOptionAlert2(String message, {String text = ""}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Center(
              child: TextWidget(
                text: message + text,
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                fontsize: 15,
                textcolor: Colors.black,
              ),
            ),

            // title: Text(message + text),
            actions: [
              ValueListenableBuilder(
                valueListenable: imageOptions,
                builder: (context, value, child) {
                  return RadioGroup<String>.builder(
                    textStyle: TextStyle(color: Colors.black),
                    groupValue: value ?? "",
                    onChanged: (value) {
                      imageOptions.value = value;
                      if (value == "Choose from Library") {
                        getImage2(ImageSource.gallery);
                      } else if (value == "Take Photo") {
                        getImage2(ImageSource.camera);
                      } else if (value == "cancel") {
                        // Navigator.pop(context);
                      }

                      Navigator.pop(context);
                      imageOptions.value = null;
                    },
                    items: AppConstants.imagePickingOptions,
                    itemBuilder: (item) => RadioButtonBuilder(
                      item,
                    ),
                  );
                },
              ),
            ],
          );
        });
    //showDialog
  }

  @override
  void initState() {
    //  NetCheck();
    super.initState();
    // print("item list ${Constants.ticktetitemslist?.tICKETID}");

    var VehicleNolen = AppConstants.ticktetitemslist?.listVehicles?.length ?? 0;
    for (var i = 0; i < VehicleNolen; i++) {
      vehicleNo.add(AppConstants.ticktetitemslist?.listVehicles?[i].vEHICLENO);
    }
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        deviceId = await generateDeviceId();
        if (await InternetCheck()) {
          EasyLoading.show();
          GetPlantIds();
          Getvehicletypes();
        } else {
          AlertsNetwork.showAlertDialog(context, TextConstants.internetcheck,
              onpressed: () {
            Navigator.pop(context);
          }, buttontext: TextConstants.ok);
        }
      },
    );
  }

  GetPlantIds() async {
    final url = ApiConstants.concessionaire_baseurl +
        ApiConstants
            .concessionaire_incharge_pickup_capture_bind_plant_name_endpoint;
    ConcessionairePickupCaptureBindPlantNameReq
        concessionairePickupCaptureBindPlantNameReq =
        new ConcessionairePickupCaptureBindPlantNameReq();
    concessionairePickupCaptureBindPlantNameReq.uSERID = AppConstants.userid;
    concessionairePickupCaptureBindPlantNameReq.pASSWORD =
        AppConstants.password;
    final payload = concessionairePickupCaptureBindPlantNameReq.toJson();
    try {
      final _dioOnject = Dio();
      final response = await _dioOnject.post(url, data: payload);

      final data =
          ConcessionairePickupCaptureBindPlantNameRes.fromJson(response.data);
      EasyLoading.dismiss();
      if (data.sTATUSCODE == "200") {
        setState(() {
          _concessionairePickupCaptureBindPlantNameRes = data;
          if (_concessionairePickupCaptureBindPlantNameRes?.pLANTDTLS != null) {
            var plantnamelistlen = _concessionairePickupCaptureBindPlantNameRes
                    ?.pLANTDTLS?.length ??
                0;
            for (var i = 0; i < plantnamelistlen; i++) {
              plantdata["Select Plant Name"] = "";
              plantdata[_concessionairePickupCaptureBindPlantNameRes
                      ?.pLANTDTLS?[i].pLANTNAME] =
                  _concessionairePickupCaptureBindPlantNameRes
                      ?.pLANTDTLS?[i].pLANTID;
            }
            print(plantdata.keys.toList());
          }
        });
      } else if (data.sTATUSCODE == "400") {
        print("${data.sTATUSMESSAGE}");
      } else if (data.sTATUSCODE == "600") {}
    } on DioError catch (e) {
      print(e);
    }
  }

  Getvehicletypes() async {
    final url = ApiConstants.concessionaire_baseurl +
        ApiConstants.concessionaire_incharge_pickup_capture_vehicletypes;

    try {
      final _dioOnject = Dio();
      final response = await _dioOnject.get(url);
      print(response.data);
      final data =
          ConcessionairePickupCaptureGetVehicleTypesRes.fromJson(response.data);
      if (data.sTATUSCODE == "200") {
        setState(() {
          _concessionairePickupCaptureGetVehicleTypesRes = data;
          if (_concessionairePickupCaptureGetVehicleTypesRes?.vEHICLELIST !=
              null) {
            var vehicletypeslen = _concessionairePickupCaptureGetVehicleTypesRes
                    ?.vEHICLELIST?.length ??
                0;
            for (var i = 0; i < vehicletypeslen; i++) {
              vehciledata["Select Vehicle Type"] = "";
              vehciledata[_concessionairePickupCaptureGetVehicleTypesRes
                      ?.vEHICLELIST?[i].vEHICLETYPE] =
                  _concessionairePickupCaptureGetVehicleTypesRes
                      ?.vEHICLELIST?[i].vEHICLETYPEID;

              vehicletypes = vehciledata.keys.toList();
              /*  vehicletypes.add(
                "${_concessionairePickupCaptureGetVehicleTypesRes?.vEHICLELIST?[i].vEHICLETYPE}"); */
            }
          }
        });
      } else if (data.sTATUSCODE == "400") {
        print("${data.sTATUSMESSAGE}");
      } else if (data.sTATUSCODE == "600") {}
    } on DioError catch (e) {
      print(e);
    }
  }

  getsubmitdetails() async {
    var empid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
    var tokenid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.tokenId);

    final url = ApiConstants.concessionaire_baseurl +
        ApiConstants.concessionaire_incharge_pickup_capture_details_submit;
    final payload = {
      "PLANT_ID": plantid,
      "CNDW_GRIEVANCE_ID": AppConstants.ticktetitemslist?.tICKETID,
      "DEVICEID": deviceId,
      "EMPLOYEE_ID": empid,
      "IS_PENDING": is_yes_flag,
      "TOKEN_ID": tokenid,
      "VEHICLE_DETAILS": [
        {
          "BEFORE_TRIP_IMAGE": _image?.path,
          "DRIVER_NAME": drivername.text,
          "MOBILE_NUMBER": mobilenumber.text,
          "VEHICLE_NUMBER": vehicleNumbersDropdown.value,
          "VEHICLE_TYPE_ID": vehicletypeid
        }
      ]
    };
    try {
      final _dioObject = Dio();
      print(payload);
      final response = await _dioObject.post(url, data: payload);
      print(response.data);
      final data = CPickupCaptureSubmitRes.fromJson(response.data);
      setState(() {
        if (data.sTATUSCODE == "200") {
          _cPickupCaptureSubmitRes = data;
        } else if (data.sTATUSCODE == "400") {
        } else if (data.sTATUSCODE == "500") {}
      });
    } on DioError catch (e) {
      print(e);
    }
  }

  showSubmitAlert(String? sTATUSMESSAGE) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    "version: 2.8",
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w200),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "GHMC Officer App",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Text(
                  "${sTATUSMESSAGE}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            // title: Text(message + text),
            actions: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        width: double.infinity,
                        // height: MediaQuery.of(context).size.height * 0.05,
                        margin: EdgeInsets.only(left: 12.0, right: 12.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color.fromARGB(255, 139, 33, 25)),
                        child: TextButton(
                          onPressed: () async {
                            setState(() {
                              submit_no = true;
                              is_yes_flag = "Y";
                            });
                            getsubmitdetails();
                            Navigator.popUntil(
                                context,
                                ModalRoute.withName(
                                    AppRoutes.concessionairepickupcapture));
                            print("in button ${vehicletypeid}");
                          },
                          child: Text(
                            TextConstants
                                .concessionaire_pickup_capture_submit_no,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        width: double.infinity,
                        // height: MediaQuery.of(context).size.height * 0.05,
                        margin: EdgeInsets.only(left: 12.0, right: 12.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color.fromARGB(255, 7, 7, 7)),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              submit_yes = true;
                              is_yes_flag = "N";
                            });
                            print("on yes button ${plantid}");
                            getsubmitdetails();
                            Navigator.popUntil(
                                context,
                                ModalRoute.withName(
                                    AppRoutes.concessionairepickupcapture));
                          },
                          child: Text(
                            TextConstants
                                .concessionaire_pickup_capture_submit_yes,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ],
              ),
            ],
          );
        }); //showDialog
  }
}
