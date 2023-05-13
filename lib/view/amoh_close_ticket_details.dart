import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghmcofficerslogin/model/amoh_close_ticket_details_submit_response.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/components/showtoast.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';
import 'package:ghmcofficerslogin/utils/device_id.dart';

class AmohCloseTicketDetails extends StatefulWidget {
  const AmohCloseTicketDetails({super.key});

  @override
  State<AmohCloseTicketDetails> createState() => _AmohCloseTicketDetailsState();
}

class _AmohCloseTicketDetailsState extends State<AmohCloseTicketDetails> {
  TextEditingController remarks = TextEditingController();
  FocusNode myFocusNode = new FocusNode();
  String? reason;
  Future<dynamic>? deviceId;
  AmohCloseTicketDetailsSubmitResponse? amohCloseTicketDetailsSubmitResponse;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.black),
            onPressed: () async {
              EasyLoading.show();
              Navigator.pushNamed(
                  context, AppRoutes.consructiondemolitionwaste);
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
            "AMOH Close Ticket Details",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(children: [
        BgImage(imgPath: ImageConstants.bg),
        SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  RowComponent(
                    TextConstants.amoh_closed_ticket_details_ticketid,
                    AppConstants.amoh_close_ticket_details?.tICKETID,
                  ),
                  RowComponent(
                    TextConstants.amoh_closed_ticket_details_ticketraiseddate,
                    AppConstants.amoh_close_ticket_details?.tICKETRAISEDDATE,
                  ),
                  RowComponent(
                    TextConstants.amoh_closed_ticket_details_ticketcloseddate,
                    AppConstants.amoh_close_ticket_details?.tICKETCLOSEDDATE,
                  ),
                  RowComponent(
                    TextConstants.amoh_closed_ticket_details_zone,
                    AppConstants.amoh_close_ticket_details?.zONENAME,
                  ),
                  RowComponent(
                    TextConstants.amoh_closed_ticket_details_circle,
                    AppConstants.amoh_close_ticket_details?.cIRCLENAME,
                  ),
                  RowComponent(
                    TextConstants.amoh_closed_ticket_details_ward,
                    AppConstants.amoh_close_ticket_details?.wARDNAME,
                  ),
                  RowComponent(
                    TextConstants.amoh_closed_ticket_details_loaction,
                    AppConstants.amoh_close_ticket_details?.lOCATION,
                  ),
                  RowComponent(
                    TextConstants.amoh_closed_ticket_details_inchargename,
                    AppConstants.amoh_close_ticket_details?.cONCESSIONERNAME,
                  ),
                  RowComponent(
                    TextConstants.amoh_closed_ticket_details_Type_of_waste,
                    AppConstants.amoh_close_ticket_details?.tYPEOFWASTE,
                  ),
                  RowComponent(
                      TextConstants.amoh_closed_ticket_details_No_of_trips, ""),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 150,
                  color: Colors.white,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: AppConstants
                          .amoh_close_ticket_details?.listVehicles?.length,
                      itemBuilder: ((context, index) {
                        final details = AppConstants
                            .amoh_close_ticket_details?.listVehicles?[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                              /*  side: BorderSide(
                                          color: Colors.black87, width: 1), */
                              ),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Column(
                              children: [
                                VehicleRowComponent(
                                  TextConstants
                                      .amoh_closed_ticket_details_vehicleno,
                                  details?.vEHICLENO,
                                ),
                                VehicleRowComponent(
                                  TextConstants
                                      .amoh_closed_ticket_details_vehicleid,
                                  details?.vEHICLEID,
                                ),
                                VehicleRowComponent(
                                  TextConstants
                                      .amoh_closed_ticket_details_drivername,
                                  details?.dRIVERNAME,
                                ),
                                VehicleRowComponent(
                                  TextConstants
                                      .amoh_closed_ticket_details_driverno,
                                  details?.dRIVERMOBILENUMBER,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Image.network(
                                        "${details?.bEFORETRIPIMAGE}",
                                        height: 100.0,
                                        width: 100.0,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            ImageConstants.no_uploaded,
                                            height: 100.0,
                                            width: 100.0,
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Image.network(
                                        "${details?.aFTERTRIPIMAGE}",
                                        height: 100.0,
                                        width: 100.0,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            ImageConstants.no_uploaded,
                                            height: 100.0,
                                            width: 100.0,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
                ),
              ),
              RowRadioComponent(
                  TextConstants.amoh_closed_ticket_details_Doyouwantto),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  focusNode: myFocusNode,
                  controller: remarks,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.text,
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
                    labelText: TextConstants.amoh_closed_ticket_details_remarks,
                  ),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.05,
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      if (remarks.text.isEmpty) {
                        // showToast("Please enter remarks");
                        ShowToats.showToast("Please enter remarks",
                            bgcolor: Colors.white, textcolor: Colors.black);
                      } else {
                        await InternetCheck()
                            ? await amohClosedTicketSubmit()
                            : AlertsNetwork.showAlertDialog(
                                context, TextConstants.internetcheck,
                                onpressed: () {
                                Navigator.pop(context);
                              }, buttontext: TextConstants.ok);
                      }
                    },
                    child: Text(
                      TextConstants.amoh_closed_ticket_details_submit,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )),
            ],
          ),
        )
      ]),
      bottomSheet: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Rights Reserved @ GHMC",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "Powered By CGG",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
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
        fontSize: 16.0);
  }

  VehicleRowComponent(var data, var value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              data.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            flex: 4,
            child: Text(
              value.toString(),
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  RowComponent(var data, var value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
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
          Expanded(
            flex: 4,
            child: Text(
              value.toString(),
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  RowRadioComponent(var data) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Row(children: <Widget>[
        Text(
          data.toString(),
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Radio(
          value: 'Y',
          groupValue: reason,
          onChanged: (val) {
            setState(() {
              reason = val.toString();
            });
          },
        ),
        Text(
          'Re Assign',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Radio(
          value: 'N',
          groupValue: reason,
          onChanged: (val) {
            setState(() {
              reason = val.toString();
              //id = 2;
            });
          },
        ),
        Text(
          'Close',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    printDeviceId();
  }

  amohClosedTicketSubmit() async {
    EasyLoading.show();
    var empid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
    var tokenid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.tokenId);

    const requestUrl = ApiConstants.cndw_baseurl +
        ApiConstants.amoh_close_amoh_closed_ticket_submit;

    final requestPayload = {
      "CNDW_GRIEVANCE_ID": AppConstants.amoh_close_ticket_details?.tICKETID,
      "EMPLOYEE_ID": empid,
      "DEVICEID": deviceId,
      "TOKEN_ID": tokenid,
      "IS_REASSIGN": reason,
      "REMARKS": remarks.text
    };

    print("payload :: ${requestPayload}");

    final dioObject = Dio();
    try {
      final response = await dioObject.post(
        requestUrl,
        data: requestPayload,
      );

      //converting response from String to json
      final data = AmohCloseTicketDetailsSubmitResponse.fromJson(response.data);
      EasyLoading.dismiss();
      print(response.data);
      setState(() {
        if (data != null) {
          if (data.sTATUSCODE == "200") {
            amohCloseTicketDetailsSubmitResponse = data;
            showDialog(
              context: context,
              builder: (context) {
                return SingleButtonDialogBox(
                    bgColor: Color.fromARGB(255, 52, 137, 37),
                    descriptions:
                        "${amohCloseTicketDetailsSubmitResponse?.sTATUSMESSAGE}",
                    img: Image.asset(ImageConstants.check),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.consructiondemolitionwaste);
                    });
              },
            );
          }
        } else if (data.sTATUSCODE == "400") {
          amohCloseTicketDetailsSubmitResponse = data;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  bgColor: Color.fromARGB(255, 202, 58, 58),
                  descriptions:
                      "${amohCloseTicketDetailsSubmitResponse?.sTATUSMESSAGE}",
                  img: Image.asset(
                    ImageConstants.cross,
                    color: Color.fromARGB(255, 202, 58, 58),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  });
            },
          );
        } else if (data.sTATUSCODE == "600") {
          amohCloseTicketDetailsSubmitResponse = data;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  bgColor: Color.fromARGB(255, 202, 58, 58),
                  descriptions:
                      "${amohCloseTicketDetailsSubmitResponse?.sTATUSMESSAGE}",
                  img: Image.asset(
                    ImageConstants.cross,
                    color: Color.fromARGB(255, 202, 58, 58),
                  ),
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
              bgColor: Color.fromARGB(255, 225, 38, 38),
              descriptions: "Network is busy.",
              img: Image.asset(ImageConstants.cross),
              onPressed: () {
                Navigator.pop(context);
              });
        },
      );

      //print("status code is ${e.response?.statusCode}");
    }
  }

  void printDeviceId() async {
    /* String deviceId = await getDeviceId();
    print('Device ID: $deviceId'); */
    String deviceId = await generateDeviceId();
    print('Device ID: $deviceId');
  }
}
