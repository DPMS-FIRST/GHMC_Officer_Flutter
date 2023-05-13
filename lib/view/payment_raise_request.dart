import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmcofficerslogin/model/raise_request_submit_response.dart';
import 'package:ghmcofficerslogin/model/request_estimation_response.dart';
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
import 'package:ghmcofficerslogin/utils/device_id.dart';
import 'package:intl/intl.dart';

class RaiseRequest extends StatefulWidget {
  const RaiseRequest({super.key});

  @override
  State<RaiseRequest> createState() => _RaiseRequestState();
}

class _RaiseRequestState extends State<RaiseRequest> {
  RequestEstimationResponse? requestEstimationResponse;
  RaiseRequestSubmitResponse? raiseRequestSubmitResponse;
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
            "Raise Request",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(children: [
        BgImage(imgPath: ImageConstants.bg),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                RowComponent(TextConstants.ticketid,
                    AppConstants.amohamountpaidlist?.tICKETID, Colors.white),
                RowComponent(
                    TextConstants.currentdate,
                    DateFormat("dd/MM/yyyy hh:mm a").format(DateTime.now()),
                    Colors.white),
                RowComponent(TextConstants.zone,
                    AppConstants.amohamountpaidlist?.zONENAME, Colors.white),
                RowComponent(TextConstants.circle,
                    AppConstants.amohamountpaidlist?.cIRCLENAME, Colors.white),
                RowComponent(TextConstants.ward,
                    AppConstants.amohamountpaidlist?.wARDNAME, Colors.white),
                RowComponent(TextConstants.location,
                    AppConstants.amohamountpaidlist?.lANDMARK, Colors.white),
                RowComponent(TextConstants.typeofwaste,
                    AppConstants.amohamountpaidlist?.tYPEOFWASTE, Colors.white),
                RowComponent(TextConstants.estimatedwasteintons,
                    AppConstants.amohamountpaidlist?.eSTWT, Colors.white),
                RowComponents(
                  TextConstants.imageofwaste,
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image.network(
                    "${AppConstants.amount_paid_image}",
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
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, right: 10.0, left: 8.0),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(flex: 2, child: Text("Vehicle Type")),
                        Expanded(flex: 2, child: Text("No of Trips")),
                        Expanded(flex: 1, child: Text("Amount")),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 4.0, right: 10.0, left: 8.0),
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                                "${AppConstants.vehicle_details_list?.vEHICLETYPE}")),
                        Expanded(
                            flex: 2,
                            child: Center(
                                child: Text(
                                    "${AppConstants.vehicle_details_list?.nOOFVEHICLES}"))),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                                    "${AppConstants.vehicle_details_list?.aMOUNT}"))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.05,
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          //showAlert(raiseRequestSubmitResponse?.sTATUSMESSAGE);
                          await InternetCheck()
                              ? await raiseRequestSubmit()
                              : AlertsNetwork.showAlertDialog(
                                  context,
                                  TextConstants.internetcheck,
                                  onpressed: () {
                                    Navigator.pop(context);
                                  },
                                  buttontext: TextConstants.ok,
                                );
                        },
                        child: Text(
                          "Forward to Concessionaire",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  divi() {
    return VerticalDivider(
      thickness: 3.0,
      color: Colors.black,
      width: 20,
      indent: 20,
      endIndent: 0,
    );
  }

  RowComponent(var data, var value, var color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
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

  raiseRequestSubmit() async {
    EasyLoading.show();
    var empid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
    var tokenid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.tokenId);

    const requestUrl =
        ApiConstants.cndw_baseurl + ApiConstants.amoh_raise_request_submit;

    final requestPayload = {
      "CNDW_GRIEVANCE_ID": AppConstants.amohamountpaidlist?.tICKETID,
      "EMPLOYEE_ID": empid,
      "DEVICEID": deviceId,
      "TOKEN_ID": tokenid,
      "IMAGE1_PATH": AppConstants.amohamountpaidlist?.iMAGE1PATH,
      "EST_WT": AppConstants.amohamountpaidlist?.eSTWT,
      "WARD_ID": AppConstants.amohamountpaidlist?.wARDID
    };

    final dioObject = Dio();

    try {
      final response = await dioObject.post(
        requestUrl,
        data: requestPayload,
      );
      EasyLoading.dismiss();
      //converting response from String to json
      final data = RaiseRequestSubmitResponse.fromJson(response.data);
      print(response.data);
      setState(() {
        if (data.sTATUSCODE == "200") {
          raiseRequestSubmitResponse = data;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  bgColor: Color.fromARGB(255, 53, 202, 27),
                  descriptions: "${raiseRequestSubmitResponse?.sTATUSMESSAGE}",
                  img: Image.asset(ImageConstants.check),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.consructiondemolitionwaste);
                  });
            },
          );
        } else if (data.sTATUSCODE == "400") {
          raiseRequestSubmitResponse = data;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  bgColor: Color.fromARGB(255, 225, 38, 38),
                  descriptions: "${raiseRequestSubmitResponse?.sTATUSMESSAGE}",
                  img: Image.asset(ImageConstants.cross),
                  onPressed: () {
                    Navigator.pop(context);
                  });
            },
          );
        } else if (data.sTATUSCODE == "600") {
          raiseRequestSubmitResponse = data;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  bgColor: Color.fromARGB(255, 225, 38, 38),
                  descriptions: "${raiseRequestSubmitResponse?.sTATUSMESSAGE}",
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
