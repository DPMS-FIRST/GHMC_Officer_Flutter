import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghmcofficerslogin/model/concessioner/c_incharge_ticketlist_req.dart';
import 'package:ghmcofficerslogin/model/concessioner/c_incharge_ticketlist_res.dart';

import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/searchbar.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/components/showtoast.dart';
import 'package:ghmcofficerslogin/res/components/textwidget.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';
import 'package:ghmcofficerslogin/utils/device_id.dart';

import '../../res/constants/Images/image_constants.dart';
import '../../res/constants/routes/app_routes.dart';

class CInchargeTicketList extends StatefulWidget {
  const CInchargeTicketList({super.key});

  @override
  State<CInchargeTicketList> createState() => _CInchargeTicketListState();
}

class _CInchargeTicketListState extends State<CInchargeTicketList> {
  CInchargeTicketListRes? _cInchargeTicketListRes;
  List<ChargeTicketList> ticketlistResponse = [];
  List<ChargeTicketList> ticketlistSearchListResponse = [];
  StreamSubscription? connection;
  bool isoffline = false;
  String? deviceId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: (() {
                Navigator.of(context).pop();
              })
              //() => Navigator.of(context).pop(),
              ),
          title: Center(
            child: Text(
              "Concenssionaire Incharge Pickup Capture list",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
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
                  onChanged: ((value) {
                    _runFilter(value);
                  }),
                  screenWidth: 1,
                  onPressed: () {},
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ListView.builder(
                      itemCount: ticketlistSearchListResponse.length,
                      itemBuilder: (context, index) {
                        final details = ticketlistSearchListResponse[index];

                        return GestureDetector(
                          onTap: () async {
                            var result =
                                await Connectivity().checkConnectivity();

                            //
                            AppConstants.c_incharge_ticket_list =
                                _cInchargeTicketListRes?.ticketList?[index];
                            AppConstants.c_incharge_ticket_list_vehicle_list =
                                _cInchargeTicketListRes
                                    ?.ticketList?[index].vehicleList?[index];
                            if (result == ConnectivityResult.wifi ||
                                result == ConnectivityResult.mobile ||
                                result == ConnectivityResult.ethernet ||
                                result == ConnectivityResult.vpn ||
                                result == ConnectivityResult.bluetooth) {
                              Navigator.pushNamed(
                                  context, AppRoutes.cinchargeticketdetails);
                            } else if (result == ConnectivityResult.none) {
                              ShowToats.showToast(TextConstants.internetcheck,
                                  bgcolor: Colors.white,
                                  gravity: ToastGravity.BOTTOM,
                                  textcolor: Colors.black);
                            }
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
                                      TextConstants
                                          .concessionaire_pickup_capturelist_ticketID,
                                      details.tICKETID,
                                    ),
                                    Line(),
                                    RowComponent(
                                      TextConstants
                                          .concessionaire_pickup_capturelist_locatio,
                                      details.lOCATION,
                                    ),
                                    Line(),
                                    RowComponent(
                                      TextConstants
                                          .concessionaire_pickup_capturelist_Landmark,
                                      details.lANDMARK,
                                    ),
                                    Line(),
                                    RowComponent(
                                      TextConstants
                                          .concessionaire_pickup_capturelist_date,
                                      details.cREATEDDATE,
                                    ),
                                    Line(),
                                    RowComponent(
                                      TextConstants
                                          .concessionaire_pickup_capturelist_estimationwaste,
                                      details.eSTWT,
                                    ),
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
                                            width: 200.0,
                                            height: 100.0,
                                          ); /* Image.asset(
                                  ImageConstants.ghmc_logo_new,
                                  width: 200.0,
                                  height: 100.0,
                                  ); */
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.all(6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rights Reserved @ GHMC",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Powered By CGG",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
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

  _runFilter(String enteredKeyword) {
    List<ChargeTicketList> results = [];
    if (enteredKeyword.isEmpty) {
      results = ticketlistResponse;
    } else {
      results = ticketlistResponse
          .where((element) => element.tICKETID!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();

      setState(() {
        ticketlistSearchListResponse = results;
      });
    }
  }

  @override
  void initState() {
    //NetCheck();

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        deviceId = await generateDeviceId();
        if (await InternetCheck()) {
          EasyLoading.show();
          getdetails();
        } else {
          AlertsNetwork.showAlertDialog(context, TextConstants.internetcheck,
              onpressed: () {
            Navigator.pop(context);
          }, buttontext: TextConstants.ok);
        }
      },
    );
  }

  getdetails() async {
    final url = ApiConstants.concessionaire_baseurl +
        ApiConstants.c_incharge_ticketlist_endpoint;
    CInchargeTicketListReq cInchargeTicketListReq =
        new CInchargeTicketListReq();
    cInchargeTicketListReq.dEVICEID = deviceId;
    cInchargeTicketListReq.eMPLOYEEID =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);

    cInchargeTicketListReq.tOKENID =
        await SharedPreferencesClass().readTheData(PreferenceConstants.tokenId);
    final payload = cInchargeTicketListReq.toJson();
    final _dioObject = Dio();
    try {
      final response = await _dioObject.post(url, data: payload);
      final data = CInchargeTicketListRes.fromJson(response.data);
      print(response.data);
      EasyLoading.dismiss();
      if (data.sTATUSCODE == "200") {
        setState(() {
          _cInchargeTicketListRes = data;
          if (_cInchargeTicketListRes?.ticketList != null) {
            ticketlistResponse = _cInchargeTicketListRes!.ticketList!;
            ticketlistSearchListResponse = ticketlistResponse;
          }
        });
      } else if (data.sTATUSCODE == "400") {
        setState(() {
          _cInchargeTicketListRes = data;
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
          _cInchargeTicketListRes = data;
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
      print(e);
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

  showAlert(String message, {String text = ""}) {
    showDialog(
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
                  print("clicked");

                  Navigator.pop(context);
                },
                child: Text(TextConstants.ok),
              )
            ],
          );
        }); //showDialog
  } //
}
