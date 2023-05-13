import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/model/user_details_response.dart';
import 'package:ghmcofficerslogin/model/user_list_response.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/logo_details.dart';
import 'package:ghmcofficerslogin/res/components/navigation.dart';
import 'package:ghmcofficerslogin/res/components/searchbar.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/components/showtoast.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';
import 'package:ghmcofficerslogin/View/display_user_details.dart';

class MyTotalGrievances extends StatefulWidget {
  const MyTotalGrievances({super.key});

  @override
  State<MyTotalGrievances> createState() => _MyTotalGrievances();
}

class _MyTotalGrievances extends State<MyTotalGrievances> {
  StreamSubscription? connection;
  bool isoffline = false;

  GrievanceUserList? grievanceUserList;
  UserDetailsResponse? userDetailsResponse;
  TextEditingController Complaint_id = TextEditingController();
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
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                /* title: const Text("GHMC Officer App",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )), */
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
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            child: LogoAndDetails(),
                          ),
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
            Container(
                child: Stack(
              children: [
                ReusableSearchbar(
                  hinttext: 'Search by Complaint Id',
                  controller: Complaint_id,
                  bgColor: Colors.white,
                  screenHeight: 0.04,
                  searchIcon: Icon(
                    Icons.search,
                    size: 40.0,
                  ),
                  topPadding: 10.0,
                  onPressed: () async {
                    if (Complaint_id.text.isNotEmpty) {
                      await SharedPreferencesClass().writeTheData(
                          PreferenceConstants.historydetails,
                          Complaint_id.text);
                      Navigator.pushNamed(context, AppRoutes.grievancehistory);
                    } else {
                      ShowToats.showToast('complaint id required');
                    }
                  },
                  screenWidth: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: ListView.builder(
                    itemCount: grievanceUserList?.rOW?.length ?? 0,
                    itemBuilder: (context, index) {
                      final datalist = grievanceUserList?.rOW?[index];

                      return GestureDetector(
                        onTap: () async {
                          await SharedPreferencesClass().writeTheData(
                              PreferenceConstants.userdetails,
                              datalist?.mODEID);

                          await SharedPreferencesClass().writeTheData(
                              PreferenceConstants.cname, datalist?.cNAME);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserDetails()));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black87, width: 1),
                          ),
                          color: Colors.transparent,
                          child: ListTile(
                            leading: Image.network(
                              "${datalist?.iURL}",
                              height: 30.0,
                            ),
                            title: Center(
                                child: Text(
                              "${datalist?.cNAME}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            )),
                            trailing: Text(
                              "${datalist?.mCOUNT}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await InternetCheck()
            ? GrievanceUserDetails()
            : AlertsNetwork.showAlertDialog(
                context, TextConstants.internetcheck, onpressed: () {
                Navigator.pop(context);
              }, buttontext: TextConstants.ok);
      },
    );
  }

  void GrievanceUserDetails() async {
    EasyLoading.show();
    var slftype = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.grievanceDashboard);
    var uid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
    var typeid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.typeid);

    const requesturl = ApiConstants.baseurl + ApiConstants.userlist_endpoint;
    print("totl grievance url :: ${requesturl}");
    //creating payload because request type is POST
    var requestPayload = {
      "userid": AppConstants.userid,
      "password": AppConstants.password,
      "uid": uid,
      "type_id": typeid,
      "slftype": slftype
    };
    print("totl grievance requestPayload :: ${requestPayload}");

    //no headers and authorization

    //creating dio object in order to connect package to server
    final dioObject = Dio();

    try {
      final response = await dioObject.post(
        requesturl,
        data: requestPayload,
      );
      print("totl grievance response :: ${response.data}");
      //converting response from String to json
      final data = GrievanceUserList.fromJson(response.data);
      EasyLoading.dismiss();
      setState(() {
        if (data.status == "true") {
          if (data.rOW != null && data.rOW!.length > 0) {
            grievanceUserList = data;
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return SingleButtonDialogBox(
                    bgColor: Color.fromARGB(255, 202, 58, 58),
                    descriptions: "${data.tag}",
                    img: Image.asset(ImageConstants.cross,
                        color: Color.fromARGB(255, 202, 58, 58)),
                    onPressed: () {
                      Navigator.pop(context);
                    });
              },
            );
          }
        } else {
          grievanceUserList = data;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  bgColor: Color.fromARGB(255, 202, 58, 58),
                  descriptions: "${data.tag}",
                  img: Image.asset(ImageConstants.cross,
                      color: Color.fromARGB(255, 202, 58, 58)),
                  onPressed: () {
                    Navigator.pop(context);
                  });
            },
          );
        }
      });
    } on DioError catch (e) {
      EasyLoading.dismiss();
        return showDialog(
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
// step 5: print the response
  }
}
