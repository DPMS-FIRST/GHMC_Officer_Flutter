import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghmcofficerslogin/model/corporator/corporator_list_req.dart';
import 'package:ghmcofficerslogin/model/corporator/corporator_list_response.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/logo_details.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/components/showtoast.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';

class CorporatorDashboard extends StatefulWidget {
  const CorporatorDashboard({super.key});

  @override
  State<CorporatorDashboard> createState() => _CorporatorDashboardState();
}

class _CorporatorDashboardState extends State<CorporatorDashboard> {
  CorporatorListResponse? corporatorListResponse;
  StreamSubscription? connection;
  bool isoffline = false;
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 2,
                        child: GridView.builder(
                          itemCount: corporatorListResponse?.rOW?.length ?? 0,
                          itemBuilder: (context, index) {
                            final data = corporatorListResponse?.rOW?[index];
                            return GestureDetector(
                              onTap: () async {
                                var result =
                                    await Connectivity().checkConnectivity();
                                // EasyLoading.show();
                                await SharedPreferencesClass().writeTheData(
                                    PreferenceConstants.menuId, data?.iMENUID);
                                if (result == ConnectivityResult.wifi ||
                                    result == ConnectivityResult.mobile ||
                                    result == ConnectivityResult.ethernet ||
                                    result == ConnectivityResult.vpn ||
                                    result == ConnectivityResult.bluetooth) {
                                  Navigator.pushNamed(
                                      context, AppRoutes.corporatorviewdoc);
                                } else if (result == ConnectivityResult.none) {
                                  ShowToats.showToast(
                                      TextConstants.internetcheck,
                                      bgcolor: Colors.white,
                                      gravity: ToastGravity.BOTTOM,
                                      textcolor: Colors.black);
                                }
                              },
                              child: Column(
                                children: [
                                  Image.network(
                                    "${data?.uRL}",
                                    height: 50,
                                    errorBuilder:
                                        ((context, error, stackTrace) {
                                      return Image.asset(
                                          ImageConstants.errorimage);
                                    }),
                                  ),
                                  Text(
                                    "${data?.mENUNAME}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: Container(
            padding: EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rights Reserved@GHMC",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  "Powered By CGG",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          )),
    );
  }

  @override
  void initState() {
    //  NetCheck();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        if (await InternetCheck()) {
          EasyLoading.show();
          corporatorListDetails();
        } else {
          AlertsNetwork.showAlertDialog(context, TextConstants.internetcheck,
              onpressed: () {
            Navigator.pop(context);
          }, buttontext: TextConstants.ok);
        }
      },
    );
  }

  void corporatorListDetails() async {
    var empID =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
    var name =
        await SharedPreferencesClass().readTheData(PreferenceConstants.name);
    print(empID);
    print(name);
    //creating request url with base url and endpoint
    // https: //19cghmc.cgg.gov.in/myghmcwebapi/Grievance/CorporatorList
    const requesturl = ApiConstants.baseurl + ApiConstants.corporatorList;

    //creating payload because request type is POST
    CorporatorListReq corporatorListReq = new CorporatorListReq();
    print(empID);
    corporatorListReq.empid = empID;
    corporatorListReq.userid = AppConstants.userid;
    corporatorListReq.password = AppConstants.password;
    var requestPayload = corporatorListReq.toJson();

    //no headers and authorization

    //creating dio object in order to connect package to server
    final dioObject = Dio();

    try {
      final response = await dioObject.post(requesturl,
          data: requestPayload,
          options: Options(headers: {
            'Content-Type': "application/json",
          }));
      //converting response from String to json
      final data = CorporatorListResponse.fromJson(response.data);
      print(response.data);

      EasyLoading.dismiss();
      setState(() {
        if (data.rOW != null) {
          corporatorListResponse = data;
        }
      });

      EasyLoading.dismiss();
    } on DioError catch (e) {
      EasyLoading.dismiss();
      showDialog(
        context: context,
        builder: (context) {
          return SingleButtonDialogBox(
              bgColor: Color.fromARGB(255, 202, 58, 58),
              descriptions: "Network is busy please try again",
              img: Image.asset(ImageConstants.cross),
              onPressed: () {
                Navigator.pop(
                  context,
                );
              });
        },
      );

      print("error is $e");

      //print("status code is ${e.response?.statusCode}");
    }
// step 5: print the response
  }

  showAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(TextConstants.no_grievance_available),
            // title: Text(message + text),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(TextConstants.ok),
              )
            ],
          );
        }); //showDialog
  } //
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
          alignment: Alignment.topLeft,
          child: Stack(
            children: [
              BgImage(imgPath: ImageConstants.bg),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.myloginpage);
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
              'Corporator Dashboard',
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
          left: MediaQuery.of(context).size.width / 4,
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
