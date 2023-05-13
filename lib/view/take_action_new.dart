import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ghmcofficerslogin/model/get_staff_response.dart';
import 'package:ghmcofficerslogin/model/get_ward_response.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/model/takeaction_response.dart';
import 'package:ghmcofficerslogin/model/update_grievance_response.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/border_textfield.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/components/showtoast.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/utils/device_id.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';
import '../res/components/textwidget.dart';
import '../res/constants/Images/image_constants.dart';
import '../res/constants/providers/provider_notifiers.dart';
import '../res/constants/text_constants/text_constants.dart';

class TakeActionNew extends StatefulWidget {
  const TakeActionNew({super.key});

  @override
  State<TakeActionNew> createState() => _TakeActionNewState();
}

class _TakeActionNewState extends State<TakeActionNew> {
  StreamSubscription? connection;
  bool isoffline = false;

  //final _formKey = GlobalKey<FormState>();
  FocusNode mobilenofocusnode = new FocusNode();
  FocusNode emailidfocusnode = new FocusNode();
  FocusNode fineamountfocusnode = new FocusNode();
  FocusNode amountfocusnode = new FocusNode();
  FocusNode proofidfocusnode = new FocusNode();
  FocusNode tradenamefocusnode = new FocusNode();
  FocusNode enterremarksfocusnode = new FocusNode();

  TextEditingController mobileno = TextEditingController();
  TextEditingController emailid = TextEditingController();
  TextEditingController fineamount = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController proofid = TextEditingController();
  TextEditingController tradename = TextEditingController();

  TextEditingController _controller = TextEditingController();
  bool modeidflag = false;
  var modeid;
  bool enterremarksflag = false;
  bool enabledropdown = false;
  var phototype = "";
  List RamkyItems = [];
  List<String> idproofs = ["select", "1", "2"];
  GetStaff? _getStaff;
  GetWard? _getWard;
  var takeaction_statusid = "";
  File? _image;
  Position? _currentPosition;
  String? deviceId;
  Future getImage(ImageSource type) async {
    final img = await ImagePicker().pickImage(source: type);
    if (img == null) return;
    final tempimg = File(img.path);
    setState(() {
      this._image = tempimg;
      final bytes = tempimg.readAsBytesSync();
      String base64Image = "" + base64Encode(bytes);
    });
  }

  TakeActionModel? takeActionModel;
  UpdateGrievanceResponse? _updateGrievanceResponse;
  Map items = {};
  List<String> warditems = [];
  final imagePickingOptions = [
    "Choose from Gallery",
    "Take Photo",
    "Choose Document",
    "cancel"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: (() {
              Navigator.of(context).pop();
              takeActionTypes1.value = "select";
              ramkyvalues1.value = "select";
            })),
        title: Center(
          child: Text(
            "Take Action",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ),
      body: modeidflag
          ? Stack(
              children: <Widget>[
                BgImage(imgPath: ImageConstants.bg),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: BorderTextfield(
                          horizantalpadding: 4.0,
                          verticalpadding: 4.0,
                          containerheight: 0.05,
                          containerwidth: 0.9,
                          controller: tradename,
                          focusNode: tradenamefocusnode,
                          hinttext: TextConstants.take_action_citizen,
                          hinttextcolor: Colors.grey,
                          contentpadding: 5.0,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ValueListenableBuilder(
                          valueListenable: takeactionIdproofsDropdown,
                          builder: ((context, value, child) {
                            return Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: DropdownButton(
                                      underline:
                                          Container(color: Colors.transparent),
                                      // value: selectedCountry.value,
                                      hint: value == null
                                          ? Text('Please Select ')
                                          : Text(
                                              value,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                      isExpanded: true,
                                      iconSize: 30.0,
                                      dropdownColor: Colors.white,
                                      iconEnabledColor: Colors.black,
                                      style: TextStyle(color: Colors.black),
                                      items: idproofs.map(
                                        (val) {
                                          return DropdownMenuItem<String>(
                                            value: val,
                                            child: Text("$val"),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (val) {
                                        takeactionIdproofsDropdown.value = val;
                                      }),
                                ),
                              ),
                            );
                          })),
                      BorderTextfield(
                        horizantalpadding: 4.0,
                        verticalpadding: 4.0,
                        containerheight: 0.05,
                        containerwidth: 0.9,
                        controller: proofid,
                        focusNode: proofidfocusnode,
                        hinttext: TextConstants.take_action_Proofid,
                        hinttextcolor: Colors.grey,
                        contentpadding: 5.0,
                        textAlign: TextAlign.start,
                      ),
                      BorderTextfield(
                        horizantalpadding: 4.0,
                        verticalpadding: 4.0,
                        containerheight: 0.05,
                        containerwidth: 0.9,
                        controller: mobileno,
                        maxlines: 10,
                        focusNode: mobilenofocusnode,
                        hinttext: TextConstants.take_action_mobileno,
                        hinttextcolor: Colors.grey,
                        contentpadding: 5.0,
                        textAlign: TextAlign.start,
                      ),
                      BorderTextfield(
                        horizantalpadding: 10.0,
                        verticalpadding: 4.0,
                        containerheight: 0.05,
                        containerwidth: 0.9,
                        controller: emailid,
                        maxlines: 10,
                        focusNode: emailidfocusnode,
                        hinttext: TextConstants.take_action_emailid,
                        hinttextcolor: Colors.grey,
                        contentpadding: 5.0,
                        textAlign: TextAlign.start,
                      ),
                      BorderTextfield(
                        horizantalpadding: 10.0,
                        verticalpadding: 4.0,
                        containerheight: 0.05,
                        containerwidth: 0.9,
                        controller: fineamount,
                        maxlines: 10,
                        focusNode: fineamountfocusnode,
                        hinttext: TextConstants.take_action_fine_amount,
                        hinttextcolor: Colors.grey,
                        contentpadding: 5.0,
                        textAlign: TextAlign.start,
                      ),
                      BorderTextfield(
                        horizantalpadding: 10.0,
                        verticalpadding: 4.0,
                        containerheight: 0.15,
                        containerwidth: 0.9,
                        controller: amount,
                        maxlines: 10,
                        focusNode: amountfocusnode,
                        hinttext: TextConstants.take_action_amount,
                        hinttextcolor: Colors.grey,
                        contentpadding: 5.0,
                        textAlign: TextAlign.start,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.92,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: Card(
                          color: Colors.transparent,
                          child: ElevatedButton(
                              onPressed: () async {
                                await InternetCheck()
                                    ? updateGrievanceDetails()
                                    : AlertsNetwork.showAlertDialog(
                                        context, TextConstants.internetcheck,
                                        onpressed: () {
                                        Navigator.pop(context);
                                      }, buttontext: TextConstants.ok);
                                if (tradename.text.isEmpty) {
                                  ShowToats.showToast("please enter trade name",
                                      gravity: ToastGravity.BOTTOM,
                                      bgcolor: Colors.white,
                                      textcolor: Colors.black);
                                } else if (takeactionIdproofsDropdown.value ==
                                    "select") {
                                  ShowToats.showToast(
                                      "please select idproof type",
                                      gravity: ToastGravity.BOTTOM,
                                      bgcolor: Colors.white,
                                      textcolor: Colors.black);
                                } else if (proofid.text.isEmpty) {
                                  ShowToats.showToast("please enter proof id",
                                      gravity: ToastGravity.BOTTOM,
                                      bgcolor: Colors.white,
                                      textcolor: Colors.black);
                                } else if (mobileno.text.isEmpty) {
                                  ShowToats.showToast("please enter mobile no",
                                      gravity: ToastGravity.BOTTOM,
                                      bgcolor: Colors.white,
                                      textcolor: Colors.black);
                                } else if (emailid.text.isEmpty) {
                                  ShowToats.showToast("please enter email ",
                                      gravity: ToastGravity.BOTTOM,
                                      bgcolor: Colors.white,
                                      textcolor: Colors.black);
                                } else if (fineamount.text.isEmpty) {
                                  ShowToats.showToast(
                                      "please enter fine  amount",
                                      gravity: ToastGravity.BOTTOM,
                                      bgcolor: Colors.white,
                                      textcolor: Colors.black);
                                } else if (amount.text.isEmpty) {
                                  ShowToats.showToast(
                                      "please enter total amount",
                                      gravity: ToastGravity.BOTTOM,
                                      bgcolor: Colors.white,
                                      textcolor: Colors.black);
                                } else {
                                  print(
                                      "msg ${_updateGrievanceResponse?.compid}");
                                  // getStaffshowAlert(
                                  //     "${_updateGrievanceResponse?.compid}");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent),
                              child: Text("Submit")),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          : Stack(
              children: <Widget>[
                BgImage(imgPath: ImageConstants.bg),
                Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: takeActionTypes1,
                      builder: (context, value, child) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.88,
                              decoration: BoxDecoration(color: Colors.white),
                              child: DropdownButton(
                                  underline:
                                      Container(color: Colors.transparent),
                                  // value: selectedCountry.value,
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
                                  items: items.keys.toList().map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text("  ${items[val]}"),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    takeaction_statusid = "${val}";
                                    takeActionTypes1.value = "${items[val]}";

                                    if (val == "10") {
                                      RamkyItems = [
                                        "select",
                                        "Claimed",
                                        "Unclaimed"
                                      ];
                                      setState(() {
                                        enabledropdown = true;
                                        ramkyvalues1.value = "select";
                                      });
                                    } else if (val == "15") {
                                      getStaffshowAlert("${_getStaff?.tag}");
                                      setState(() {
                                        enabledropdown = false;
                                      });
                                    } else if (val == "4") {
                                      RamkyItems = warditems;
                                      setState(() {
                                        enabledropdown = true;
                                        ramkyvalues1.value = "select";
                                      });
                                    } else {
                                      setState(() {
                                        enabledropdown = false;
                                      });
                                    }
                                  }),
                            ),
                          ),
                        );
                      },
                    ),
                    enabledropdown ? subDropdown() : Text(""),
                    Center(
                        child: Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.88,
                      child: SizedBox(
                        height: 100,
                        child: TextField(
                          maxLines: null,
                          controller: _controller,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 8.0),
                              hintText: "Enter Your Remarks",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    )),
                    SizedBox(height: 40),
                    _image != null
                        ? GestureDetector(
                            onTap: (() {
                              showAlert("Add Photo");
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
                                  showAlert("Add Photo");
                                }),
                                icon: Icon(Icons.camera_alt_outlined),
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Card(
                      color: Colors.transparent,
                      child: ElevatedButton(
                          onPressed: () async {
                            var result =
                                await Connectivity().checkConnectivity();
                            if (result == ConnectivityResult.mobile ||
                                result == ConnectivityResult.wifi) {
                              await updateGrievanceDetails();
                              items.forEach((key, value) {
                                if (value == takeActionTypes1.value) {
                                  var check = key;
                                  switch (check) {
                                    case "0":
                                      ShowToats.showToast(
                                          "please select complaint status",
                                          gravity: ToastGravity.BOTTOM,
                                          bgcolor: Colors.white,
                                          textcolor: Colors.black);
                                      break;
                                    case "1":
                                      if (_controller.text.isEmpty) {
                                        ShowToats.showToast(
                                            "please enter remarks",
                                            gravity: ToastGravity.BOTTOM,
                                            bgcolor: Colors.white,
                                            textcolor: Colors.black);
                                      } else if (_image?.path == null) {
                                        ShowToats.showToast(
                                            "please select image",
                                            gravity: ToastGravity.BOTTOM,
                                            bgcolor: Colors.white,
                                            textcolor: Colors.black);
                                      } else {
                                        getStaffshowAlert(
                                            "${_updateGrievanceResponse?.compid}");
                                      }
                                      break;
                                    case "4":
                                      if (ramkyvalues1.value == "select") {
                                        ShowToats.showToast(
                                            "please select sub complaint status",
                                            gravity: ToastGravity.BOTTOM,
                                            bgcolor: Colors.white,
                                            textcolor: Colors.black);
                                      } else if (_controller.text.isEmpty) {
                                        ShowToats.showToast(
                                            "please enter remarks",
                                            gravity: ToastGravity.BOTTOM,
                                            bgcolor: Colors.white,
                                            textcolor: Colors.black);
                                      } else {
                                        getStaffshowAlert(
                                            "${_updateGrievanceResponse?.compid}");
                                      }
                                      break;
                                    case "10":
                                      if (ramkyvalues1.value == "select") {
                                        ShowToats.showToast(
                                            "please select status",
                                            gravity: ToastGravity.BOTTOM,
                                            bgcolor: Colors.white,
                                            textcolor: Colors.black);
                                      } else if (_controller.text.isEmpty) {
                                        ShowToats.showToast(
                                            "please enter remarks",
                                            gravity: ToastGravity.BOTTOM,
                                            bgcolor: Colors.white,
                                            textcolor: Colors.black);
                                      } else {
                                        getStaffshowAlert(
                                            "${_updateGrievanceResponse?.compid}");
                                      }
                                      break;
                                    default:
                                      if (_controller.text.isEmpty) {
                                        ShowToats.showToast(
                                            "please enter remarks",
                                            gravity: ToastGravity.BOTTOM,
                                            bgcolor: Colors.white,
                                            textcolor: Colors.black);
                                      } else {
                                        getStaffshowAlert(
                                            "${_updateGrievanceResponse?.compid}");
                                      }
                                  }
                                }
                              });
                            } else if (result == ConnectivityResult.none) {
                              ShowToats.showToast(
                                  "Check your internet connection",
                                  gravity: ToastGravity.BOTTOM,
                                  bgcolor: Colors.white,
                                  textcolor: Colors.black);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent),
                          child: Text("Submit")),
                    ),
                  ),
                ),
              ],
            ),
    ); /*   */
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        deviceId = await generateDeviceId();
        _getCurrentPosition();
        if (await InternetCheck()) {
          fetchDetails();
          ForwarToLowerStaffDetails();
          GetWardDetails();
        } else {
          AlertsNetwork.showAlertDialog(context, TextConstants.internetcheck,
              onpressed: () {
            Navigator.pop(context);
          }, buttontext: TextConstants.ok);
        }
      },
    );
    super.initState();
  }

  fetchDetails() async {
    EasyLoading.show();
    // modeid = "15";
    modeid = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.userdetails);
    print("mode id ${modeid}");
    if (modeid == "15") {
      setState(() {
        modeidflag = true;
      });
    } else {
      setState(() {
        modeidflag = false;
      });
    }
    var typeid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.typeid);
    var des = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.designation);
    const url = ApiConstants.baseurl + ApiConstants.takeaction_endpoint;
    print("take action url::${url}");
    // "https://19cghmc.cgg.gov.in/myghmcwebapi/Grievance/getStatusType";
    final pload = {
      "userid": AppConstants.userid,
      "password": AppConstants.password,
      "type_id": typeid,
      "designation": des
    };
    print("take action pload::${pload}");

    final _dioObject = Dio();
    try {
      final _response = await _dioObject.post(url, data: pload);
      var len = _response.data.length;
      //print(_response.data.length);
      EasyLoading.dismiss();
      print("take action _response::${_response}");

      for (var i = 0; i < len; i++) {
        final data = TakeActionModel.fromJson(_response.data[i]);

        setState(() {
          if (data != null) {
            if (data.status == "success") {
              takeActionModel = data;
              items[takeActionModel?.id] = takeActionModel?.type;
            } else {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return SingleButtonDialogBox(
                      bgColor: Color.fromARGB(255, 202, 58, 58),
                      descriptions: "Network is busy please try again",
                      img: Image.asset(ImageConstants.cross,
                          color: Color.fromARGB(255, 202, 58, 58)),
                      onPressed: () {
                        Navigator.pop(context);
                      });
                },
              );
            }
          }
        });
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

  //forward to lower staff
  ForwarToLowerStaffDetails() async {
    EasyLoading.show();
    var empid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
    const url =
        ApiConstants.baseurl + ApiConstants.takeaction_getlowerstaff_endpoint;
    // "https://19cghmc.cgg.gov.in/myghmcwebapi/Grievance/getLowerStaff?empId=978";

    final _dioObject = Dio();
    try {
      final _response =
          await _dioObject.get(url, queryParameters: {"empId": empid});
      final data = GetStaff.fromJson(_response.data);
      EasyLoading.dismiss();
      setState(() {
        _getStaff = data;
      });
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

  GetWardDetails() async {
    EasyLoading.show();
    const url = ApiConstants.baseurl + ApiConstants.get_ward_endpoint;

    final _dioObject = Dio();
    final getward_payload = {
      "userid": AppConstants.userid,
      "password": AppConstants.password
    };

    try {
      final _response = await _dioObject.post(url, data: getward_payload);
      final data = GetWard.fromJson(_response.data);
      EasyLoading.dismiss();
      //print(data.tag);
      if (data.status == "true") {
        setState(() {
          EasyLoading.dismiss();
          _getWard = data;
        });
        print(_getWard?.tag);

        var ward_len = _getWard?.data?.length ?? 0;
        // print(ward_len);

        for (var i = 1; i < ward_len; i++) {
          // print(_getWard!.data![i].ward);
          warditems.add(_getWard!.data![i].ward.toString());
        }
      }
      // print(warditems);
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

  updateGrievanceDetails() async {
    EasyLoading.show();
    print("mode in grievance  ${modeid}");
    var compid = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.historydetails);
    const url = ApiConstants.baseurl + ApiConstants.update_grievance_end_point;
    var typeid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.typeid);
    var mobileno = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.mobileno);
    var name =
        await SharedPreferencesClass().readTheData(PreferenceConstants.name);

    final payload = {
      "userid": AppConstants.userid,
      "password": AppConstants.password,
      "type_id": typeid,
      "mobileno":
          "${mobileno}-${name}-{\"userid\":\"${AppConstants.userid}\",\"password\":\"${AppConstants.password}\",\"type_id\":\"${typeid}\"}",
      "updatedstatus": takeaction_statusid,
      "compId": compid,
      "remarks": _controller.text,
      "latlon": "${_currentPosition?.latitude},${_currentPosition?.longitude}",
      "deviceid": deviceId,
      "no_of_trips": "",
      "total_net_weight": amount.text,
      "trader_name": tradename.text,
      "id_proof_type": takeactionIdproofsDropdown.value,
      "id_proof_no": proofid.text,
      "nmos_mobile_no": "",
      "email": emailid.text,
      "fine_amount": fineamount.text,
      "source": modeid,
      "vehicleNo": "",
      "photo": "",
      "PhotoType": phototype,
      "claimant_status": "",
      "lower_staff_id": ""
    };
    print("payload ${payload}");
    final _dioObject = Dio();
    try {
      final _response = await _dioObject.post(url, data: payload);
      final data = UpdateGrievanceResponse.fromJson(_response.data);
      print(_response.data);
      EasyLoading.dismiss();
      setState(() {
        if (data != null) {
          _updateGrievanceResponse = data;
        } else {
          Alerts.showAlertDialog(context, "No data available",
              Title: "GHMC OFFICER APP", onpressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.myloginpage);
          }, buttontext: "Ok", buttoncolor: Colors.red);
        }
      });
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

  getStaffshowAlert(String message, {String text = ""}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: TextWidget(
              text: message + text,
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              fontsize: 15,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (message == _getStaff?.tag) {
                    Navigator.pop(context);
                    takeActionTypes1.value = "select";
                    ramkyvalues1.value = "select";
                  } else if (message == _updateGrievanceResponse?.compid) {
                    if (_updateGrievanceResponse?.status == "False") {
                      Navigator.pushNamed(context, AppRoutes.takeaction);
                    } else if (_updateGrievanceResponse?.status == "True") {
                      Navigator.pushNamed(context, AppRoutes.ghmcdashboard);
                      takeActionTypes1.value = "select";
                      ramkyvalues1.value = "select";
                    }
                  }
                },
                child: Text(
                  TextConstants.ok,
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              )
            ],
          );
        }); //showDialog
  }

  showAlert(String message, {String text = ""}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 45, 88, 124),
            title: Center(
              child: TextWidget(
                text: message + text,
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                fontsize: 15,
                textcolor: Colors.white,
              ),
            ),

            // title: Text(message + text),
            actions: [
              ValueListenableBuilder(
                valueListenable: imageOptions,
                builder: (context, value, child) {
                  return RadioGroup<String>.builder(
                    textStyle: TextStyle(color: Colors.white),
                    groupValue: value ?? "",
                    onChanged: (value) {
                      imageOptions.value = value;
                      phototype = imageOptions.value!;
                      if (value == "Choose Document") {
                        getImage(ImageSource.gallery);
                      } else if (value == "Take Photo") {
                        getImage(ImageSource.camera);
                      } else if (value == "Choose from Gallery") {
                        getImage(ImageSource.gallery);
                      } else if (value == "cancel") {
                        // Navigator.pop(context);
                      }
                      Navigator.pop(context);
                    },
                    items: imagePickingOptions,
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

  subDropdown() {
    return ValueListenableBuilder(
      valueListenable: ramkyvalues1,
      builder: (context, value, child) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 20),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.88,
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
                  items: RamkyItems.map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text("$val"),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    print("$val");
                    ramkyvalues1.value = "$val";
                  }),
            ),
          ),
        );
      },
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

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services adre disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

//get current location
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
// Failed to update complaint 3012222534512
// False