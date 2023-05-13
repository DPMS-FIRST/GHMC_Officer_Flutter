import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghmcofficerslogin/model/get_vehicles_reponse.dart';
import 'package:ghmcofficerslogin/model/request_estimation_response.dart';
import 'package:ghmcofficerslogin/model/request_estimation_submit_response.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/image_capture.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';
import 'package:ghmcofficerslogin/utils/base64.dart';
import 'package:ghmcofficerslogin/utils/device_id.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../res/components/sharedpreference.dart';
import '../res/constants/Images/image_constants.dart';
import '../res/constants/providers/provider_notifiers.dart';

class RequestEstimation extends StatefulWidget {
  const RequestEstimation({super.key});

  @override
  State<RequestEstimation> createState() => _RequestEstimationState();
}

class _RequestEstimationState extends State<RequestEstimation> {
  RequestEstimationResponse? requestEstimationResponse;
  GetVehiclesResponse? getVehiclesResponse;
  RequestEstimationSubmitResponse? requestEstimationSubmitResponse;
  var noOfTrips = 0,
      vehicletypeNo = 0,
      amount = 0,
      amounttext = 0,
      deletedestcount = 0;
  var estd = 0;
  var amountd = 0;
  var estwcount = 0;
  String? deviceId;
  List vehicletype = ["Select Vehicle Type"];
  TextEditingController tripsController = TextEditingController();
  TextEditingController estimatedWasteController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool ListItem = false;
  bool textamount = false;
  var amt;
  var vehicleid;
  var amountCount;

  var amountoriginal;
  XFile imageData1 = XFile("");
  String base64_img1 = "";
  var i1;
  List names = [];

  String noOfTripUpdatevalue = '';

  @override
  Widget build(BuildContext context) {
    //EasyLoading.dismiss();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.black),
            onPressed: () async {
              names.clear();
              Navigator.pushNamed(
                  context, AppRoutes.consructiondemolitionwaste);
            },
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: (() {
              Navigator.of(context).pop();
            })),
        title: Center(
          child: Text(
            "Request Estimation",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(
        children: [
          BgImage(imgPath: ImageConstants.bg),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RowComponent(TextConstants.ticketid,
                      AppConstants.request_list_ticket_id, Colors.white),
                  RowComponent(
                      TextConstants.currentdate,
                      DateFormat("dd/MM/yyyy hh:mm a").format(DateTime.now()),
                      Colors.white),
                  RowComponent(TextConstants.zone,
                      requestEstimationResponse?.zONEID ?? "", Colors.white),
                  RowComponent(TextConstants.circle,
                      requestEstimationResponse?.cIRCLEID ?? "", Colors.white),
                  RowComponent(TextConstants.ward,
                      requestEstimationResponse?.wARDID ?? "", Colors.white),
                  RowComponent(TextConstants.location,
                      requestEstimationResponse?.lANDMARK ?? "", Colors.white),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Image.network(
                      "${AppConstants.request_list_image}",
                      height: 100.0,
                      width: 100.0,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          ImageConstants.no_uploaded,
                          height: 100.0,
                          width: 100.0,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  RowComponent(
                      TextConstants.typeofwaste,
                      requestEstimationResponse?.tYPEOFWASTE ?? "",
                      Colors.white),
                  RowComponents(
                    TextConstants.imageofwaste,
                  ),
                  ImageCapture(
                    callbackValue: (imageData) {
                      imageData1 = imageData;
                      base64_img1 = convertToBase64(imageData1.path);
                      print("image data1 ::: ${base64_img1}");
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Add Vehicles",
                                hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (vehicletype.length > 1) {
                            showModalBottomSheet(
                                isDismissible: false,
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return customBottomSheet();
                                });
                          } else {
                            showToast("There are no vehicles to select");
                          }
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      )
                    ],
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: names.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Card(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showAlert(
                                              names[index]["vehicle_type"],
                                              names[index]["amount_original"],
                                              (value) {
                                            setState(() {
                                              noOfTripUpdatevalue = value;
                                            });
                                          }, () {
                                            setState(() {
                                              names[index]["no_of_trips"] =
                                                  noOfTripUpdatevalue;

                                              names[index]["amount_count"] =
                                                  int.parse(names[index]
                                                          ["no_of_trips"]) *
                                                      int.parse(names[index]
                                                          ["amount_original"]);

                                              int estwcoun = 0;
                                              int totalamount = 0;
                                              names.forEach((element) {
                                                int noOfTrips = int.parse(
                                                    element["no_of_trips"]);
                                                int vehicleTypeNo =
                                                    element["vehicletypeno"];

                                                estwcoun +=
                                                    noOfTrips * vehicleTypeNo;
                                                totalamount += int.parse(
                                                    element["amount_count"]
                                                        .toString());
                                              });

                                              estimatedWasteController.text =
                                                  estwcoun.toString();
                                              amountController.text =
                                                  totalamount.toString();
                                            });

                                            Navigator.pop(context);
                                          });
                                        },
                                        icon: Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          vehicletype.add(
                                              names[index]["vehicle_type"]);
                                          setState(() {
                                            names.removeAt(index);
                                            int estCountAfterDeletion = 0;
                                            int totalAmountAfterDeletion = 0;
                                            names.forEach((element) {
                                              int noOfTrips = int.parse(
                                                  element["no_of_trips"]);
                                              int vehicleTypeNo =
                                                  element["vehicletypeno"];

                                              estCountAfterDeletion +=
                                                  noOfTrips * vehicleTypeNo;
                                              totalAmountAfterDeletion +=
                                                  int.parse(
                                                      element["amount_count"]
                                                          .toString());
                                            });
                                            estimatedWasteController.text =
                                                estCountAfterDeletion
                                                    .toString();
                                            amountController.text =
                                                totalAmountAfterDeletion
                                                    .toString();
                                            print("after deletion ${names}");
                                          });
                                        },
                                        icon: Icon(Icons.delete)),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  children: [
                                    RowComponent(
                                        "Vehicle Type",
                                        names[index]["vehicle_type"],
                                        Colors.teal),
                                    RowComponent(
                                        "No of Trips",
                                        names[index]["no_of_trips"],
                                        Colors.teal),
                                    RowComponent(
                                        "Amount",
                                        names[index]["amount_count"],
                                        Colors.teal)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  textamount
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 20.0),
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                enabled: false,
                                controller: estimatedWasteController,
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    labelText:
                                        TextConstants.estimatedwasteintons,
                                    labelStyle: TextStyle(color: Colors.white)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 20.0),
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                enabled: false,
                                controller: amountController,
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    labelText: TextConstants.amount,
                                    labelStyle: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        )
                      : Text(""),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.05,
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            if (base64_img1.isEmpty) {
                              showToast("Please select image");
                            } else if (names.isEmpty) {
                              showToast("Please add atleast one vehicle data");
                            } else {
                              List vehicle_details = [];
                              names.forEach((element) {
                                vehicle_details.add({
                                  "NO_OF_TRIPS": element["no_of_trips"],
                                  "VEHICLE_TYPE_ID": element["vehicleid"]
                                });
                              });
                              await InternetCheck()
                                  ? await requestEstimationSubmit(
                                      vehicle_details)
                                  : AlertsNetwork.showAlertDialog(
                                      context, TextConstants.internetcheck,
                                      onpressed: () {
                                      Navigator.pop(context);
                                    }, buttontext: TextConstants.ok);
                            }
                          },
                          child: Text(
                            "SUBMIT",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.05,
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: TextButton(
                      onPressed: () {
                        var lat = double.parse(
                            "${requestEstimationResponse?.lATITUDE}");
                        var long = double.parse(
                            "${requestEstimationResponse?.lONGITUDE}");
                        navigateTo(lat, long);
                      },
                      child: Text(
                        "VIEW DIRECTIONS",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  RowComponent(var data, var value, var color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              data.toString(),
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 4,
            child: Text(
              value.toString(),
              style: TextStyle(color: color, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  RowComponents(var data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              data.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          SizedBox(
            width: 4,
          ),
        ],
      ),
    );
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  customBottomSheet() {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 200,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Vehicle Type",
                style: TextStyle(color: Colors.black),
              ),
              ValueListenableBuilder(
                valueListenable: vehicletypeslist,
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 20.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: DropdownButton(
                            underline: Container(color: Colors.transparent),
                            hint: value == null
                                ? Text('Select Vehicle Type')
                                : Text(
                                    " " + "${value}",
                                    style: TextStyle(color: Colors.black),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            dropdownColor: Colors.white,
                            iconEnabledColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            items: vehicletype.map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text("  ${val}"),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              vehicletypeslist.value = val;

                              var vehicletypelistlen =
                                  getVehiclesResponse?.vEHICLELIST?.length ?? 0;
                              amt = 0;
                              for (int i = 0; i < vehicletypelistlen; i++) {
                                if (vehicletypeslist.value ==
                                    getVehiclesResponse
                                        ?.vEHICLELIST?[i].vEHICLETYPE) {
                                  amt = getVehiclesResponse
                                      ?.vEHICLELIST?[i].aMOUNT;

                                  vehicleid = getVehiclesResponse
                                      ?.vEHICLELIST?[i].vEHICLETYPEID;
                                }
                              }
                            }),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: tripsController,
                  decoration: InputDecoration(
                      hintText: "No of Trips",
                      hintStyle: TextStyle(color: Colors.teal)),
                ),
              ),
              Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.05,
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (vehicletypeslist.value == 'Select Vehicle Type') {
                        showToast("Select Vehicle Type");
                      } else if (tripsController.text == '' ||
                          tripsController.text.startsWith("0")) {
                        showToast("Please enter valid number");
                      } else {
                        setState(() {
                          ListItem = true;
                          textamount = true;
                          var f = vehicletypeslist.value?.split(" ");

                          var len = f?.length;
                          var vehicleno = f?[len! - 2];
                          vehicletypeNo = int.parse("${vehicleno}");
                          names.add({
                            "vehicle_type": vehicletypeslist.value,
                            "no_of_trips": tripsController.text,
                            "amount_count": int.parse(tripsController.text) *
                                int.parse(amt),
                            "amount_original": amt,
                            "vehicleid": vehicleid,
                            "vehicletypeno": vehicletypeNo
                          });

                          int estCount = 0;
                          int totalAmount = 0;
                          names.forEach((element) {
                            int noOfTrips = int.parse(element["no_of_trips"]);
                            int vehicleTypeNo = element["vehicletypeno"];

                            estCount += noOfTrips * vehicleTypeNo;
                            totalAmount +=
                                int.parse(element["amount_count"].toString());
                          });
                          estimatedWasteController.text = estCount.toString();
                          amountController.text = totalAmount.toString();
                        });
                        Navigator.pop(context);
                        var vehicletypelistlen =
                            getVehiclesResponse?.vEHICLELIST?.length ?? 0;

                        for (int i = 0; i < vehicletypelistlen; i++) {
                          if (names[i]["vehicle_type"] ==
                              vehicletypeslist.value) {
                            vehicletype.remove(vehicletypeslist.value);
                            vehicletypeslist.value = "Select Vehicle Type";
                            tripsController.text = "";
                          }
                        }
                      }
                    },
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  showAlert(var value, var amounttxt, void Function(String)? onchanged,
      void Function()? onpressed) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              RowComponent("Vehicle Type", value, Colors.teal),
              RowComponent("Amount(as per trips)", amounttxt, Colors.teal),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  onChanged: onchanged,
                  keyboardType: TextInputType.number,
                  controller: tripsController,
                  decoration: InputDecoration(
                      hintText: "No of Trips",
                      hintStyle: TextStyle(color: Colors.teal)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        color: Colors.teal,
                        child: TextButton(
                            onPressed: onpressed,
                            child: Text(
                              "UPDATE",
                              style: TextStyle(color: Colors.white),
                            ))),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        color: Colors.teal,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "CANCEL",
                              style: TextStyle(color: Colors.white),
                            )))
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  showSubmitAlert(String? sTATUSMESSAGE) {
    showDialog(
        barrierDismissible: false,
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
              Container(
                  width: double.infinity,
                  // height: MediaQuery.of(context).size.height * 0.05,
                  margin: EdgeInsets.only(left: 12.0, right: 12.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color.fromARGB(255, 53, 202, 27)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.popUntil(
                          context,
                          ModalRoute.withName(
                              AppRoutes.consructiondemolitionwaste));
                    },
                    child: Text(
                      TextConstants.request_estimation_ok,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )),
            ],
          );
        }); //showDialog
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        deviceId = await generateDeviceId();
        if (await InternetCheck()) {
          getRequestEstimationDetails();
          getVehicleType();
        } else {
          AlertsNetwork.showAlertDialog(context, TextConstants.internetcheck,
              onpressed: () {
            Navigator.pop(context);
          }, buttontext: TextConstants.ok);
        }
      },
    );
  }

  requestEstimationSubmit(List vehicleDetails) async {
    print("ticket id ::: ${AppConstants.request_list_ticket_id}");
    EasyLoading.show();
    var empid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
    var tokenId =
        await SharedPreferencesClass().readTheData(PreferenceConstants.tokenId);
    const requestUrl = ApiConstants.cndw_baseurl +
        ApiConstants.request_estimation_submit_endpoint;

    print("request url ::: ${requestUrl}");

    final requestPayload = {
      "CNDW_GRIEVANCE_ID": AppConstants.request_list_ticket_id,
      "EMPLOYEE_ID": empid,
      "DEVICEID": deviceId,
      "TOKEN_ID": tokenId,
      "IMAGE1_PATH": base64_img1,
      "EST_WT": estimatedWasteController.text,
      "AMOUNT": amountController.text,
      "VEHICLE_DETAILS": vehicleDetails,
    };

    print("payload ::: ${requestPayload}");

    final dioObject = Dio();

    try {
      final response = await dioObject.post(
        requestUrl,
        data: requestPayload,
      );

      //converting response from String to json
      final data = RequestEstimationSubmitResponse.fromJson(response.data);
      EasyLoading.dismiss();
      print(response.data);

      if (data.sTATUSCODE == "200") {
        setState(() {
          requestEstimationSubmitResponse = data;
        });
        print(
            "submit response ${requestEstimationSubmitResponse?.sTATUSMESSAGE}");
        return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return SingleButtonDialogBox(
                bgColor: Color.fromARGB(255, 225, 38, 38),
                descriptions:
                    "${requestEstimationSubmitResponse?.sTATUSMESSAGE}",
                img: Image.asset(ImageConstants.cross),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.consructiondemolitionwaste);
                });
          },
        );
        //showSubmitAlert(requestEstimationSubmitResponse?.sTATUSMESSAGE);
      } else if (data.sTATUSCODE == "400") {
        setState(() {
          requestEstimationSubmitResponse = data;
        });
        return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return SingleButtonDialogBox(
                bgColor: Color.fromARGB(255, 225, 38, 38),
                descriptions:
                    "${requestEstimationSubmitResponse?.sTATUSMESSAGE}",
                img: Image.asset(ImageConstants.cross),
                onPressed: () {
                  Navigator.pop(context);
                });
          },
        );
      } else if (data.sTATUSCODE == "600") {
        setState(() {
          requestEstimationSubmitResponse = data;
        });
        return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return SingleButtonDialogBox(
                bgColor: Color.fromARGB(255, 225, 38, 38),
                descriptions:
                    "${requestEstimationSubmitResponse?.sTATUSMESSAGE}",
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

  getRequestEstimationDetails() async {
    EasyLoading.show();
    var tokenid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.tokenId);
    var empid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
    const requestUrl =
        ApiConstants.cndw_baseurl + ApiConstants.request_estimation_endpoint;

    print("estimation url ::: ${requestUrl}");

    final requestPayload = {
      "CNDW_GRIEVANCE_ID": AppConstants.request_list_ticket_id,
      "EMPLOYEE_ID": empid,
      "DEVICEID": deviceId,
      "TOKEN_ID": tokenid
    };

    print("estimation details requestPayload ::: ${requestPayload}");

    final dioObject = Dio();

    try {
      final response = await dioObject.post(
        requestUrl,
        data: requestPayload,
      );

      //converting response from String to json
      final data = RequestEstimationResponse.fromJson(response.data);
      EasyLoading.dismiss();
      print(response.data);

      if (data.sTATUSCODE == "200") {
        setState(() {
          requestEstimationResponse = data;
        });
      } else if (data.sTATUSCODE == "400") {
        setState(() {
          requestEstimationResponse = data;
        });
        return showDialog(
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
          requestEstimationResponse = data;
        });
        return showDialog(
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

  getVehicleType() async {
    EasyLoading.show();
    const requestUrl =
        ApiConstants.cndw_baseurl + ApiConstants.get_vehicle_type;

    final dioObject = Dio();

    try {
      final response = await dioObject.get(
        requestUrl,
      );
      //var len = response.data.length;
      //converting response from String to json
      final data = GetVehiclesResponse.fromJson(response.data);
      //print(response.data);
      EasyLoading.dismiss();
      setState(() {
        if (data.sTATUSCODE == "200") {
          getVehiclesResponse = data;
          if (getVehiclesResponse?.vEHICLELIST != null) {
            var vehicletypelistlen =
                getVehiclesResponse?.vEHICLELIST?.length ?? 0;
            for (var i = 0; i < vehicletypelistlen; i++) {
              vehicletype
                  .add("${getVehiclesResponse?.vEHICLELIST?[i].vEHICLETYPE}");
            }
          }
        } else if (data.sTATUSCODE == "400") {
          setState(() {
            getVehiclesResponse = data;
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
            getVehiclesResponse = data;
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
      });
    } on DioError catch (e) {
      showDialog(
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
