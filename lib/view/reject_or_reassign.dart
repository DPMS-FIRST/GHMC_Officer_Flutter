import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghmcofficerslogin/model/amoh_reassign_concessioner_rejected_tickets_response.dart';
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

class RejectOrReassign extends StatefulWidget {
  const RejectOrReassign({super.key});

  @override
  State<RejectOrReassign> createState() => _RejectOrReassignState();
}

class _RejectOrReassignState extends State<RejectOrReassign> {
  final locationList = ["Re Assign", "Close"];
  TextEditingController remarks = TextEditingController();
  FocusNode myFocusNode = new FocusNode();
  AmohReassignConcessionerRejectedTicketsResponse?
      amohReassignConcessionerRejectedTicketsResponse;
  String? reason;
  String? deviceId;
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
            "Reject/Re Assign",
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
                    AppConstants.consessioner_rejected_ticket_id, Colors.white),
                RowComponents(TextConstants.image),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image.network(
                    "${AppConstants.consessioner_rejected_image}",
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
                RowComponent(
                    TextConstants.reasonsforrejection,
                    AppConstants.consessioner_rejected_reasons_for_rejection,
                    Colors.white),
                RowRadioComponent(TextConstants.reject_reassign_doyouwantto),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    focusNode: myFocusNode,
                    controller: remarks,
                    style: const TextStyle(color: Colors.white),
                    //keyboardType: TextInputType.number,
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
                          fontSize: 18.0),
                      labelText: TextConstants.remarks,
                    ),
                  ),
                ),
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
                          if (remarks.text.isEmpty) {
                            ShowToats.showToast("Please enter remarks",
                                bgcolor: Colors.white, textcolor: Colors.black);
                          } else {
                            await InternetCheck()
                                ? await rejectReassignSubmit()
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
                          TextConstants.reject_reassign_submit,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ]),
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
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
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

  RowRadioComponent(var data) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
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
              print("reason reassign -------- ${reason}");
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
              print("reason close -------- ${reason}");
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      deviceId = await generateDeviceId();
    });
  }

  rejectReassignSubmit() async {
    EasyLoading.show();
    var tokenid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.tokenId);
    var empid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);

    const requestUrl = ApiConstants.cndw_baseurl +
        ApiConstants.amoh_reassign_concessioner_rejected_tickets;

    print("url :::  ${requestUrl}");

    final requestPayload = {
      "TICKET_ID": AppConstants.consessioner_rejected_ticket_id,
      "DEVICEID": deviceId,
      "TOKEN_ID": tokenid,
      "AMOH_EMPID": empid,
      "IS_REASSIGN": reason,
      "REMARKS_FOR_REASSIGN": remarks.text
    };
    print("reassign payload --------- ${requestPayload}");

    final dioObject = Dio();

    try {
      final response = await dioObject.post(
        requestUrl,
        data: requestPayload,
      );
      //converting response from String to json
      final data = AmohReassignConcessionerRejectedTicketsResponse.fromJson(
          response.data);
      print("reassign response ${response.data}");
      EasyLoading.dismiss();
      setState(() {
        if (data != null) {
          if (data.sTATUSCODE == "200") {
            amohReassignConcessionerRejectedTicketsResponse = data;

            showDialog(
              context: context,
              builder: (context) {
                return SingleButtonDialogBox(
                    bgColor: Color.fromARGB(255, 52, 137, 37),
                    descriptions:
                        "${amohReassignConcessionerRejectedTicketsResponse?.sTATUSMESSAGE}",
                    img: Image.asset(
                      ImageConstants.check,
                      color: Color.fromARGB(255, 52, 137, 37),
                    ),
                    onPressed: () {
                      Navigator.popUntil(
                          context,
                          ModalRoute.withName(
                              AppRoutes.consructiondemolitionwaste));
                    });
              },
            );
          }
        } else if (data.sTATUSCODE == "400") {
          amohReassignConcessionerRejectedTicketsResponse = data;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  bgColor: Color.fromARGB(255, 202, 58, 58),
                  descriptions:
                      "${data.sTATUSMESSAGE}",
                  img: Image.asset(
                    ImageConstants.cross,
                    color: Color.fromARGB(255, 202, 58, 58),
                  ),
                  onPressed: () {
                    Navigator.pop(
                        context);
                  });
            },
          );
        }else if (data.sTATUSCODE == "600") {
          amohReassignConcessionerRejectedTicketsResponse = data;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  bgColor: Color.fromARGB(255, 202, 58, 58),
                  descriptions:
                      "${data.sTATUSMESSAGE}",
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
