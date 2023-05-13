import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghmcofficerslogin/model/concessioner/concessionaire_incharge_manual_closing_tickets_res.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showtoast.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/utils/device_id.dart';

import '../../model/concessioner/concessionaire_incharge_manual_closing_tickets_req.dart';

import '../../res/components/background_image.dart';
import '../../res/components/searchbar.dart';
import '../../res/components/showalert_singlebutton.dart';
import '../../res/constants/Images/image_constants.dart';
import '../../res/constants/text_constants/text_constants.dart';

class ConcessionaireInchargeManualClosingTicketsList extends StatefulWidget {
  const ConcessionaireInchargeManualClosingTicketsList({super.key});

  @override
  State<ConcessionaireInchargeManualClosingTicketsList> createState() =>
      _ConcessionaireInchargeManualClosingTicketsListState();
}

class _ConcessionaireInchargeManualClosingTicketsListState
    extends State<ConcessionaireInchargeManualClosingTicketsList> {
  ConcessionaireInchargeManualClosingTicketsListRes?
      _manualClosingTicketsListRes;
  List<TicketList> ticketlistResponse = [];
  List<TicketList> ticketlistSearchListResponse = [];
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
                  child: ListView.builder(
                      itemCount: ticketlistSearchListResponse.length,
                      itemBuilder: ((context, index) {
                        final items = ticketlistSearchListResponse[index];
                        return GestureDetector(
                          onTap: () async {
                            AppConstants
                                    .concessionaireInchargeManualClosingTicketlist =
                                _manualClosingTicketsListRes
                                    ?.ticketList?[index];
                            Navigator.pushNamed(
                                context,
                                AppRoutes
                                    .concessionaireinchargemanualclosingtickets);
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
                                            .concenssionaire_incharge_manual_closing_tciketslist_ticketid,
                                        items.tICKETID),
                                    Line(),
                                    RowComponent(
                                      TextConstants
                                          .concenssionaire_incharge_manual_closing_tciketslist_locatio,
                                      items.lOCATION,
                                    ),
                                    Line(),
                                    RowComponent(
                                      TextConstants
                                          .concenssionaire_incharge_manual_closing_tciketslist_date,
                                      items.cREATEDDATE,
                                    ),
                                    Line(),
                                    RowComponent(
                                      TextConstants
                                          .concenssionaire_incharge_manual_closing_tciketslist_zone,
                                      items.zONENAME,
                                    ),
                                    Line(),
                                    RowComponent(
                                      TextConstants
                                          .concenssionaire_incharge_manual_closing_tciketslist_circle,
                                      items.cIRCLENAME,
                                    ),
                                    RowComponent(
                                      TextConstants
                                          .concenssionaire_incharge_manual_closing_tciketslist_ward,
                                      items.wARDNAME,
                                    ),
                                    RowComponent(
                                      TextConstants
                                          .concenssionaire_incharge_manual_closing_tciketslist_estimationwaste,
                                      items.eSTWT,
                                    ),
                                    RowComponent(
                                      TextConstants
                                          .concenssionaire_incharge_manual_closing_tciketslist_status,
                                      items.sTATUS,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Image.network(
                                        "${items.iMAGE1PATH}",
                                        height: 100.0,
                                        width: 100.0,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            ImageConstants.no_uploaded,
                                            width: 200.0,
                                            height: 100.0,
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
                      })),
                ),
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) async {
      deviceId = await generateDeviceId();
      if (await InternetCheck()) {
        EasyLoading.show();
        print("internet check ::${InternetCheck()}");
        Getdetails();
      } else {
        AlertsNetwork.showAlertDialog(context, TextConstants.internetcheck,
            onpressed: () {
          Navigator.pop(context);
        }, buttontext: TextConstants.ok);
      }
    });
  }

  Getdetails() async {
    final url = ApiConstants.concessionaire_baseurl +
        ApiConstants.concessionaire_incharge_manual_closing_tickets_endpoint;
    ConcessionaireInchargeManualClosingTicketsListReq
        concessionaireInchargeManualClosingTicketsListReq =
        new ConcessionaireInchargeManualClosingTicketsListReq();
    concessionaireInchargeManualClosingTicketsListReq.dEVICEID = deviceId;
    concessionaireInchargeManualClosingTicketsListReq.eMPLOYEEID =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
    concessionaireInchargeManualClosingTicketsListReq.tOKENID =
        await SharedPreferencesClass().readTheData(PreferenceConstants.tokenId);
    final payload = concessionaireInchargeManualClosingTicketsListReq.toJson();
    final _dioObject = Dio();

    try {
      final response = await _dioObject.post(url, data: payload);
      final data = ConcessionaireInchargeManualClosingTicketsListRes.fromJson(
          response.data);
      EasyLoading.dismiss();
      if (data.sTATUSCODE == "200") {
        setState(() {
          _manualClosingTicketsListRes = data;
          ticketlistResponse = _manualClosingTicketsListRes!.ticketList!;
          ticketlistSearchListResponse = ticketlistResponse;
        });
      } else if (data.sTATUSCODE == "400") {
        setState(() {
          _manualClosingTicketsListRes = data;
          ticketlistResponse = _manualClosingTicketsListRes!.ticketList!;
          ticketlistSearchListResponse = ticketlistResponse;
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
          _manualClosingTicketsListRes = data;
          ticketlistResponse = _manualClosingTicketsListRes!.ticketList!;
          ticketlistSearchListResponse = ticketlistResponse;
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
      print(_manualClosingTicketsListRes?.ticketList?[0].cIRCLENAME);
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

  Line() {
    return Divider(
      thickness: 1.0,
      color: Colors.grey,
    );
  }

  showAlertImage(String? photo, BuildContext context) async {
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
    List<TicketList> results = [];
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
}
