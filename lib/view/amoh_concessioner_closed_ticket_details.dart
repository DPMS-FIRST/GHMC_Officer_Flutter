import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmcofficerslogin/model/amoh_cclose_ticket_res.dart';
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

class AmohCCloseTicketDetails extends StatefulWidget {
  const AmohCCloseTicketDetails({super.key});

  @override
  State<AmohCCloseTicketDetails> createState() => _AmohCCloseTicketDetails();
}

class _AmohCCloseTicketDetails extends State<AmohCCloseTicketDetails> {
  FocusNode myFocusNode = new FocusNode();
  TextEditingController remarks = new TextEditingController();
  String? reason;
  AmohConcessionerCloseTicketSubmitResponse?
      amohConcessionerCloseTicketSubmitResponse;
  String? deviceId;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        EasyLoading.show();
        deviceId = await generateDeviceId();
      },
    );
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
            })
            //() => Navigator.of(context).pop(),
            ),
        title: Center(
          child: Text(
            " Concessionaire Close Ticket Details",
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
                    TextConstants.amoh_c_closed_ticket_details_ticketid,
                    AppConstants.amoh_closedticketlist?.tICKETID,
                  ),
                  RowComponent(
                    TextConstants.amoh_c_closed_ticket_details_ticketraiseddate,
                    AppConstants.amoh_closedticketlist?.tICKETRAISEDDATE,
                  ),
                  RowComponent(
                    TextConstants.amoh_c_closed_ticket_details_ticketcloseddate,
                    AppConstants.amoh_closedticketlist?.tICKETCLOSEDDATE,
                  ),
                  RowComponent(
                    TextConstants.amoh_c_closed_ticket_details_zone,
                    AppConstants.amoh_closedticketlist?.zONENAME,
                  ),
                  RowComponent(
                    TextConstants.amoh_c_closed_ticket_details_circle,
                    AppConstants.amoh_closedticketlist?.cIRCLENAME,
                  ),
                  RowComponent(
                    TextConstants.amoh_c_closed_ticket_details_ward,
                    AppConstants.amoh_closedticketlist?.wARDNAME,
                  ),
                  RowComponent(
                    TextConstants.amoh_c_closed_ticket_details_loaction,
                    AppConstants.amoh_closedticketlist?.lOCATION,
                  ),
                  RowComponent(
                    TextConstants.amoh_c_closed_ticket_details_inchargename,
                    AppConstants.amoh_closedticketlist?.cONCESSIONERNAME,
                  ),
                  RowComponent(
                    TextConstants.amoh_c_closed_ticket_details_Type_of_waste,
                    AppConstants.amoh_closedticketlist?.tYPEOFWASTE,
                  ),
                  RowComponent(
                      TextConstants.amoh_c_closed_ticket_details_No_of_trips,
                      ""),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 150,
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount: AppConstants
                          .amoh_closedticketlist?.listVehicles?.length,
                      itemBuilder: ((context, index) {
                        final details = AppConstants
                            .amoh_closedticketlist?.listVehicles?[index];
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
                                  TextConstants.amoh_c_closed_ticket_vehicleno,
                                  details?.vEHICLENO,
                                ),
                                VehicleRowComponent(
                                  TextConstants.amoh_c_closed_ticket_vehicleid,
                                  details?.vEHICLEID,
                                ),
                                VehicleRowComponent(
                                  TextConstants.amoh_c_closed_ticket_drivername,
                                  details?.dRIVERNAME,
                                ),
                                VehicleRowComponent(
                                  TextConstants.amoh_c_closed_ticket_driverno,
                                  details?.dRIVERMOBILENUMBER,
                                ),
                                //
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 15.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          TextConstants
                                              .amoh_c_closed_ticket_beforetrip
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          TextConstants
                                              .amoh_closed_ticket_aftertrip
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
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
                    labelText: TextConstants
                        .concenssionaire_incharge_manual_closing_tickets_remarks,
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
                        ShowToats.showToast("Please enter remarks",
                            bgcolor: Colors.white, textcolor: Colors.black);
                      } else {
                        await InternetCheck()
                            ? await amohConcessionerCloseTicketSubmit()
                            : AlertsNetwork.showAlertDialog(
                                context,
                                TextConstants.internetcheck,
                                onpressed: () {
                                  Navigator.pop(context);
                                },
                                buttontext: TextConstants.ok,
                              );
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
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
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

  Future<void> amohConcessionerCloseTicketSubmit() async {
    EasyLoading.show();
    var empid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
    var tokenid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.tokenId);

    const requestUrl =
        ApiConstants.cndw_baseurl + ApiConstants.amoh_c_close_ticket_submit;
    print("request :: ${requestUrl}");

    final requestPayload = {
      "CNDW_GRIEVANCE_ID": AppConstants.amoh_closedticketlist?.tICKETID,
      "EMPLOYEE_ID": empid,
      "DEVICEID": deviceId,
      "TOKEN_ID": tokenid,
      "IS_REASSIGN": reason,
      "REMARKS": remarks.text
    };
    print("requestPayload :: ${requestPayload}");

    final dioObject = Dio();
    try {
      final response = await dioObject.post(
        requestUrl,
        data: requestPayload,
      );

      //converting response from String to json
      final data =
          AmohConcessionerCloseTicketSubmitResponse.fromJson(response.data);
      EasyLoading.dismiss();
      print(response.data);

      setState(() {
        if (data != null) {
          if (data.sTATUSCODE == "200") {
            amohConcessionerCloseTicketSubmitResponse = data;
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return SingleButtonDialogBox(
                    bgColor: Color.fromARGB(255, 60, 159, 66),
                    descriptions:
                        "${amohConcessionerCloseTicketSubmitResponse?.sTATUSMESSAGE}",
                    img: Image.asset(
                      ImageConstants.check,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.consructiondemolitionwaste);
                    });
              },
            );
          }
        } else if (data.sTATUSCODE == "400") {
          amohConcessionerCloseTicketSubmitResponse = data;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  bgColor: Color.fromARGB(255, 202, 58, 58),
                  descriptions:
                      "${amohConcessionerCloseTicketSubmitResponse?.sTATUSMESSAGE}",
                  img: Image.asset(
                    ImageConstants.cross,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  });
            },
          );
        } else if (data.sTATUSCODE == "600") {
          amohConcessionerCloseTicketSubmitResponse = data;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  bgColor: Color.fromARGB(255, 202, 58, 58),
                  descriptions:
                      "${amohConcessionerCloseTicketSubmitResponse?.sTATUSMESSAGE}",
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
      EasyLoading.show();
      return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SingleButtonDialogBox(
              bgColor: Color.fromARGB(255, 202, 58, 58),
              descriptions: "Network is busy please try again",
              img: Image.asset(ImageConstants.cross,),
              onPressed: () {
                Navigator.pop(context);
              });
        },
      );
    }
  }
}
