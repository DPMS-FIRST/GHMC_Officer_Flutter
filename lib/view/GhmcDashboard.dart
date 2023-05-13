import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmcofficerslogin/model/dashboardModel.dart';
import 'package:ghmcofficerslogin/model/dashboard_response.dart';
import 'package:ghmcofficerslogin/model/mobile_menu_list_response.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/logo_details.dart';
import 'package:ghmcofficerslogin/res/components/navigation.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';
import 'package:ghmcofficerslogin/view/total_grievances.dart';
import 'package:intl/intl.dart';

class GhmcDashboard extends StatefulWidget {
  const GhmcDashboard({super.key});

  @override
  State<GhmcDashboard> createState() => _GhmcDashboardState();
}

class _GhmcDashboardState extends State<GhmcDashboard> {
  StreamSubscription? connection;
  bool isoffline = false;
  late DashboardResponse grievanceData;
  MobileMenuListResponse? mobileMenuListResponse;
  List<DashboardMenu>? dashboardMenu;
  List<GrievanceDashboard>? grievanceDashboard;
  var versionNumber;
  String? currentDateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ReusableNavigation(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: MediaQuery.of(context).size.height * 0.2,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: SizedBox(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        child: Image.asset(
                          ImageConstants.bg,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Center(
                        child: Container(
                          child: LogoAndDetails(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: Stack(
          children: [
            BgImage(imgPath: ImageConstants.bg),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Text(
                        "Version : ${versionNumber ?? ''}",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Text(
                        "${currentDateTime ?? ''}",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ListView.builder(
                          itemCount: grievanceDashboard?.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                if (grievanceDashboard?[index].count == "0") {
                                  AlertWithOk.showAlertDialog(
                                      context, "No Grievance Available",
                                      onpressed: () {
                                    Navigator.pop(context);
                                  }, buttontext: TextConstants.ok);
                                } else {
                                  String grievanceDashboardId =
                                      grievanceDashboard?[index].iD ?? '';
                                  SharedPreferencesClass().writeTheData(
                                      PreferenceConstants.grievanceDashboard,
                                      grievanceDashboardId);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MyTotalGrievances(),
                                      ));
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    side: BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                  color: Colors.transparent,
                                  child: ListTile(
                                    title: Text(
                                      "${grievanceDashboard?[index].mENUNAME ?? ''}",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    ),
                                    trailing: Text(
                                      "${grievanceDashboard?[index].count ?? ''}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: dashboardMenu?.length ?? 0,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            final data = dashboardMenu?[index];
                            return GestureDetector(
                              onTap: () async {
                                await SharedPreferencesClass().writeTheData(
                                    PreferenceConstants.grievance_type,
                                    data?.iMENUID);
                                if (data?.iMENUID == "34") {
                                  Navigator.pushNamed(
                                      context, AppRoutes.veternaryform);
                                } else if (data?.iMENUID == "37") {
                                  Navigator.pushNamed(context,
                                      AppRoutes.consructiondemolitionwaste);
                                } else if (data?.iMENUID == "38") {
                                  Navigator.pushNamed(
                                      context, AppRoutes.raisegrievance);
                                } else if (data?.iMENUID == "35") {
                                  Navigator.pushNamed(
                                      context, AppRoutes.checkstatusnew);
                                } else {
                                  Navigator.pushNamed(
                                      context, AppRoutes.newcomplaint);
                                }
                              },
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        "${data?.mENUNAME}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      versionNumber = await SharedPreferencesClass()
          .readTheData(PreferenceConstants.versionNumber);
      DateTime date = DateTime.now();
      currentDateTime = DateFormat('dd/MM/yyyy hh:mm').format(date);
      await InternetCheck()
          ? GrievanceDetails()
          : AlertsNetwork.showAlertDialog(context, TextConstants.internetcheck,
              onpressed: () {
              Navigator.pop(context);
            }, buttontext: TextConstants.ok);
    });
  }

  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  void GrievanceDetails() async {
    EasyLoading.show();
    var uid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
    var typeid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.typeid);
    //creating request url with base url and endpoint
    const requesturl = ApiConstants.baseurl + ApiConstants.endpoint;
    print("ghmc dashboard ::: ${requesturl}");

    //creating payload because request type is POST
    var requestPayload = {
      "userid": AppConstants.userid,
      "password": AppConstants.password,
      "uid": uid,
      "type_id": typeid
    };
    print("ghmc dashboard payload :::: ${requestPayload}");
    //no headers and authorization

    //creating dio object in order to connect package to server
    final dioObject = Dio();

    try {
      final response = await dioObject.post(
        requesturl,
        data: requestPayload,
      );
      print("ghmc dashboard response :: ${response}");
      //converting response from String to json
      final data = GhmcDashboardResponse.fromJson(response.data);
      print("ghmc response ${response.data}");
      EasyLoading.dismiss();
      setState(() {
        if (data.status == "true") {
          if (data.grievanceDashboard != null &&
              data.grievanceDashboard!.length > 0) {
            grievanceDashboard = data.grievanceDashboard;
            dashboardMenu = data.dashboardMenu;
          } else {
            grievanceDashboard = data.grievanceDashboard;
            dashboardMenu = data.dashboardMenu;
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return SingleButtonDialogBox(
                    bgColor: Color.fromARGB(255, 202, 58, 58),
                    descriptions: "${data.statusMessage}",
                    img: Image.asset(ImageConstants.cross,
                        color: Color.fromARGB(255, 202, 58, 58)),
                    onPressed: () {
                      Navigator.popUntil(
                          context,
                          ModalRoute.withName(
                              AppRoutes.consructiondemolitionwaste));
                    });
              },
            );
          }
        } else {
          grievanceDashboard = data.grievanceDashboard;
          dashboardMenu = data.dashboardMenu;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  bgColor: Color.fromARGB(255, 202, 58, 58),
                  descriptions: "${data.statusMessage}",
                  img: Image.asset(ImageConstants.cross,
                      color: Color.fromARGB(255, 202, 58, 58)),
                  onPressed: () {
                    Navigator.popUntil(
                        context,
                        ModalRoute.withName(
                            AppRoutes.consructiondemolitionwaste));
                  });
            },
          );
        }
      });
      print("grievance data ::: ${grievanceDashboard}");
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
