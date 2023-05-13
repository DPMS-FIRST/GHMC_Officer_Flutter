import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmcofficerslogin/model/amoh_dashboard_response.dart';
import 'package:ghmcofficerslogin/model/request_by_amoh_response.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/logo_details.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';
import 'package:ghmcofficerslogin/utils/device_id.dart';

class AmohDashboardList extends StatefulWidget {
  const AmohDashboardList({super.key});

  @override
  State<AmohDashboardList> createState() => _AmohDashboardList();
}

class _AmohDashboardList extends State<AmohDashboardList> {
  StreamSubscription? connection;
  bool isoffline = false;
  AMOHDashboardListResponse? amohDashboardListResponse;
  RequestByAmohResponse? requestByAmohResponse;
  String? deviceId;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverPersistentHeader(
                  delegate: MySliverAppBar(expandedHeight: 200.0),
                  pinned: true,
                ),
              ];
            },
            body: Stack(
              children: [
                BgImage(imgPath: ImageConstants.bg),
                Column(
                  children: [
                    listCardWidget(
                      text1: 'No of Requests by Citizen',
                      text2:
                          '${amohDashboardListResponse?.aMOHList?[0].nOOFREQUESTS ?? ""}',
                      onTap: (() async {
                        if (amohDashboardListResponse
                                ?.aMOHList?[0].nOOFREQUESTS ==
                            "0") {
                          AlertWithOk.showAlertDialog(
                              context, "No records available", onpressed: () {
                            Navigator.pop(context);
                          },
                              buttontext: TextConstants.ok,
                              buttontextcolor: Colors.teal);
                        } else {
                          Navigator.pushNamed(context, AppRoutes.requestlist);
                        }
                      }),
                    ),
                    listCardWidget(
                        text1: 'No of Requests by AMOH',
                        text2:
                            '${requestByAmohResponse?.citizenList?.length ?? ''}',
                        onTap: () async {
                          if (requestByAmohResponse?.citizenList?.length ==
                              "0") {
                            AlertWithOk.showAlertDialog(
                                context, "No records available", onpressed: () {
                              Navigator.pop(context);
                            },
                                buttontext: TextConstants.ok,
                                buttontextcolor: Colors.teal);
                          } else {
                            Navigator.pushNamed(
                                context, AppRoutes.requestbyamoh);
                          }
                        }),
                    listCardWidget(
                      text1: 'Payment Confirmation',
                      text2:
                          '${amohDashboardListResponse?.aMOHList?[0].pAYMENTCONFIRMATION ?? ""}',
                      onTap: (() async {
                        if (amohDashboardListResponse
                                ?.aMOHList?[0].pAYMENTCONFIRMATION ==
                            "0") {
                          AlertWithOk.showAlertDialog(
                              context, "No records available", onpressed: () {
                            Navigator.pop(context);
                          },
                              buttontext: TextConstants.ok,
                              buttontextcolor: Colors.teal);
                        } else {
                          Navigator.pushNamed(
                              context, AppRoutes.amohamountpayedlist);
                        }
                      }),
                    ),
                    listCardWidget(
                        text1: 'Raise Request',
                        text2: '',
                        onTap: () async {
                          Navigator.pushNamed(
                              context, AppRoutes.raiserequest_raiserequest);
                        }),
                    listCardWidget(
                        text1: 'Concessioner Rejected',
                        text2:
                            '${amohDashboardListResponse?.aMOHList?[0].cONCESSIONERREJECTED ?? ""}',
                        onTap: () async {
                          if (amohDashboardListResponse
                                  ?.aMOHList?[0].cONCESSIONERREJECTED ==
                              "0") {
                            AlertWithOk.showAlertDialog(
                                context, "No records available", onpressed: () {
                              Navigator.pop(context);
                            },
                                buttontext: TextConstants.ok,
                                buttontextcolor: Colors.teal);
                          } else {
                            Navigator.pushNamed(
                                context, AppRoutes.rejectedtickets);
                          }
                        }),
                    listCardWidget(
                        text1: 'Concessioner Close Tickets',
                        text2:
                            '${amohDashboardListResponse?.aMOHList?[0].cONCESSIONERCLOSETICKETS ?? ""}',
                        onTap: () async {
                          if (amohDashboardListResponse
                                  ?.aMOHList?[0].cONCESSIONERCLOSETICKETS ==
                              "0") {
                            AlertWithOk.showAlertDialog(
                                context, "No records available", onpressed: () {
                              Navigator.pop(context);
                            },
                                buttontext: TextConstants.ok,
                                buttontextcolor: Colors.teal);
                          } else {
                            Navigator.pushNamed(
                                context, AppRoutes.closedticketlist);
                          }
                        }),
                    listCardWidget(
                        text1: 'AMOH Close Tickets',
                        text2:
                            '${amohDashboardListResponse?.aMOHList?[0].aMOHCLOSETICKETS ?? ""}',
                        onTap: () async {
                          if (amohDashboardListResponse
                                  ?.aMOHList?[0].aMOHCLOSETICKETS ==
                              "0") {
                            AlertWithOk.showAlertDialog(
                                context, "No records available", onpressed: () {
                              Navigator.pop(context);
                            },
                                buttontext: TextConstants.ok,
                                buttontextcolor: Colors.teal);
                          } else {
                            Navigator.pushNamed(
                                context, AppRoutes.amohclosedticketlist);
                          }
                        }),
                  ],
                )
              ],
            )),
      ),
    );
  }

  Widget listCardWidget(
      {required String text1, required text2, required Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black87, width: 1),
        ),
        color: Colors.transparent,
        margin: const EdgeInsets.all(4.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text1,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                text2,
                style: const TextStyle(fontSize: 14.0, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        deviceId = await generateDeviceId();

        if (await InternetCheck()) {
          fetchAmohDashboardDetails();
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

  fetchAmohDashboardDetails() async {
    EasyLoading.show();
    var tokenid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.tokenId);
    var empid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
    const requestUrl =
        ApiConstants.cndw_baseurl + ApiConstants.amoh_dash_list_endpoint;

    print("amoh dashboard request url :::::: ${requestUrl}");

    final requestPayload = {
      "EMPLOYEE_ID": empid,
      "DEVICEID": deviceId,
      "TOKEN_ID": tokenid
    };

    print("amoh dashboard payload :::: ${requestPayload}");

    final dioObject = Dio();

    try {
      final response = await dioObject.post(
        requestUrl,
        data: requestPayload,
      );

      //converting response from String to json
      final data = AMOHDashboardListResponse.fromJson(response.data);
      EasyLoading.dismiss();
      print(response.data);
      setState(() {
        if (data.sTATUSCODE == "200") {
          if (data.aMOHList != null) {
            amohDashboardListResponse = data;
          }
        } else if (data.sTATUSCODE == "400") {
          amohDashboardListResponse = data;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  bgColor: Color.fromARGB(255, 225, 38, 38),
                  descriptions: "${amohDashboardListResponse?.sTATUSMESSAGE}",
                  img: Image.asset(ImageConstants.cross),
                  onPressed: () {
                    Navigator.pop(context);
                  });
            },
          );
        } else if (data.sTATUSCODE == "600") {
          amohDashboardListResponse = data;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  bgColor: Color.fromARGB(255, 225, 38, 38),
                  descriptions: "${amohDashboardListResponse?.sTATUSMESSAGE}",
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
      showDialog(
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
      print("error is $e");

      //print("status code is ${e.response?.statusCode}");
    }
  }

  getdetails() async {
    EasyLoading.show();
    var tokenid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.tokenId);
    var empid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
    const requestUrl =
        ApiConstants.cndw_baseurl + ApiConstants.amoh_request_by_endpoint;

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
      final data = RequestByAmohResponse.fromJson(response.data);
      EasyLoading.dismiss();
      print(response.data);
      setState(() {
        if (data.sTATUSCODE == "200") {
          if (data.citizenList != null) {
            requestByAmohResponse = data;
          }
        } else if (data.sTATUSCODE == "400") {
          requestByAmohResponse = data;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  bgColor: Color.fromARGB(255, 225, 38, 38),
                  descriptions: "${requestByAmohResponse?.sTATUSMESSAGE}",
                  img: Image.asset(ImageConstants.cross),
                  onPressed: () {
                    Navigator.pop(context);
                  });
            },
          );
        } else if (data.sTATUSCODE == "600") {
          requestByAmohResponse = data;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  bgColor: Color.fromARGB(255, 225, 38, 38),
                  descriptions: "${requestByAmohResponse?.sTATUSMESSAGE}",
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

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          alignment: Alignment.center,
          child: Stack(
            children: [
              BgImage(imgPath: ImageConstants.bg),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: const Text(
              'AMOH Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 5 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 3,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Column(
              children: [
                Center(
                  child: Container(
                    child: LogoAndDetails(),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
