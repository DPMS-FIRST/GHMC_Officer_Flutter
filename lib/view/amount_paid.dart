import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmcofficerslogin/model/amount_paid_response.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/searchbar.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/components/textwidget.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';
import 'package:ghmcofficerslogin/utils/device_id.dart';

import '../res/components/sharedpreference.dart';
import 'payment_raise_request.dart';

class AmohAmountPayedList extends StatefulWidget {
  const AmohAmountPayedList({super.key});

  @override
  State<AmohAmountPayedList> createState() => _AmohAmountPayedListState();
}

class _AmohAmountPayedListState extends State<AmohAmountPayedList> {
  StreamSubscription? connection;
  bool isoffline = false;
  AmountPaidListResponse? amountPaidListResponse;
  List<PaidList> _paidListResponse = [];
  List<PaidList> _paidSearchListResponse = [];
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
              "Amount Payed List",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            BgImage(imgPath: ImageConstants.bg),
            Column(
              children: [
                ReusableSearchbar(
                  bgColor: Colors.white,
                  screenHeight: 0.05,
                  searchIcon: Icon(Icons.search),
                  topPadding: 8.0,
                  onChanged: (value) => _runFilter(value),
                  screenWidth: 1,
                  onPressed: () {},
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ListView.builder(
                      itemCount: _paidSearchListResponse.length,
                      itemBuilder: (context, index) {
                        final details = _paidSearchListResponse[index];

                        return GestureDetector(
                          onTap: () async {
                            AppConstants.vehicle_details_list =
                                amountPaidListResponse
                                    ?.paidList?[index].vehicleDetailsList?[0];
                            AppConstants.amohamountpaidlist =
                                amountPaidListResponse?.paidList?[index];

                            //EasyLoading.show();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RaiseRequest(),
                                ));
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.black87, width: 1),
                              ),
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Column(
                                  children: [
                                    RowComponent(
                                      TextConstants.ticketid,
                                      details.tICKETID,
                                    ),
                                    Line(),
                                    RowComponent(
                                      TextConstants.location,
                                      details.lOCATION,
                                    ),
                                    Line(),
                                    RowComponent(
                                      TextConstants.date,
                                      details.cREATEDDATE,
                                    ),
                                    Line(),
                                    RowComponent(
                                      TextConstants.estimatedwasteintons,
                                      details.eSTWT,
                                    ),
                                    Line(),
                                    RowComponent(
                                      TextConstants.status,
                                      details.sTATUS,
                                    ),
                                    Line(),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Image.network(
                                        "${details.iMAGE1PATH}",
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
                            ),
                          ),
                        );
                      }),
                )),
              ],
            ),
          ],
        ));
  }

  Line() {
    return Divider(
      thickness: 1.0,
      color: Colors.grey,
    );
  }

  _runFilter(String enteredKeyword) {
    List<PaidList> results = [];
    if (enteredKeyword.isEmpty) {
      results = _paidListResponse;
    } else {
      print(enteredKeyword);
      results = _paidListResponse
          .where((element) => element.tICKETID!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();

      setState(() {
        _paidSearchListResponse = results;
        print(_paidSearchListResponse.length);
      });
    }
  }

  showAlertImage(String? photo) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            actions: [
              Center(
                  child: Container(
                      child: Image.network(
                photo!,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(ImageConstants.no_uploaded);
                },
              ))),
            ],
          );
        });
  }

  RowComponent(var data, var value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              data.toString(),
              style: TextStyle(
                  color: Color.fromARGB(255, 125, 120, 120),
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        deviceId = await generateDeviceId();
        await InternetCheck()
            ? getdetails()
            : AlertsNetwork.showAlertDialog(
                context, TextConstants.internetcheck, onpressed: () {
                Navigator.pop(context);
              }, buttontext: TextConstants.ok);
      },
    );
  }

  getdetails() async {
    EasyLoading.show();
    var tokenid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.tokenId);
    var empid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
    const requestUrl =
        ApiConstants.cndw_baseurl + ApiConstants.amoh_paid_list_endpoint;

    final requestPayload = {
      "EMPLOYEE_ID": empid,
      "DEVICEID": deviceId,
      "TOKEN_ID": tokenid,
    };

    final dioObject = Dio();

    try {
      final response = await dioObject.post(
        requestUrl,
        data: requestPayload,
      );

      //converting response from String to json
      final data = AmountPaidListResponse.fromJson(response.data);
      EasyLoading.dismiss();
      print(response.data);
      setState(() {
        if (data.sTATUSCODE == "200") {
          if (data.paidList != null) {
            amountPaidListResponse = data;
            _paidListResponse = amountPaidListResponse!.paidList!;
            _paidSearchListResponse = _paidListResponse;
          }
        } else if (data.sTATUSCODE == "400") {
          amountPaidListResponse = data;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  bgColor: Color.fromARGB(255, 225, 38, 38),
                  descriptions: "${amountPaidListResponse?.sTATUSMESSAGE}",
                  img: Image.asset(ImageConstants.cross),
                  onPressed: () {
                    Navigator.pop(context);
                  });
            },
          );
        } else if (data.sTATUSCODE == "600") {
          amountPaidListResponse = data;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  bgColor: Color.fromARGB(255, 225, 38, 38),
                  descriptions: "${amountPaidListResponse?.sTATUSMESSAGE}",
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
              img: Image.asset(ImageConstants.cross,),
              onPressed: () {
                Navigator.pop(context);
              });
        },
      );

      //print("status code is ${e.response?.statusCode}");
    }
  }
}
