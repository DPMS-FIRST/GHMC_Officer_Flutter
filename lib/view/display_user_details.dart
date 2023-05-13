import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmcofficerslogin/model/login_response_model.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/model/user_details_response.dart';
import 'package:ghmcofficerslogin/model/user_list_response.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  StreamSubscription? connection;
  bool isoffline = false;
  UserDetailsResponse? userDetailsResponse;
  GrievanceUserList? grievanceUserList;
  LoginResponse? loginResponse;

  String? name;
  String? desig;
  String? employee_level;
  String? source_name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            TextConstants.display_user_details,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: <Widget>[
            BgImage(imgPath: ImageConstants.bg),
            Column(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2.0, vertical: 6.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 8.0),
                            child: Column(
                              children: [
                                RowComponent(TextConstants.name, name ?? ""),
                                RowComponent(
                                  TextConstants.designation,
                                  desig ?? "",
                                ),
                                RowComponent(
                                  TextConstants.employee_level,
                                  employee_level ?? "",
                                ),
                                RowComponent(TextConstants.wing,
                                    userDetailsResponse?.wing ?? ""),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Center(
                              child: Text(
                                TextConstants.grievance_details_as_on_date,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 10.0),
                          child: Row(
                            children: [
                              Text(
                                "Source : ",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                              ),
                              Text(
                                "${source_name}",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount:
                                  userDetailsResponse?.dashboard?.length ?? 0,
                              itemBuilder: (context, index) {
                                final details =
                                    userDetailsResponse?.dashboard?[index];
                                return GestureDetector(
                                  onTap: () async {
                                    SharedPreferencesClass().writeTheData(
                                        PreferenceConstants.fulldetails,
                                        details?.typeId);
                                    Navigator.pushNamed(context,
                                        AppRoutes.fullgrievancedetails);
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.black87, width: 1),
                                    ),
                                    color: Colors.transparent,
                                    child: ListTile(
                                      title: Text(
                                        "${details?.typeName}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0),
                                      ),
                                      trailing: Text(
                                        "${details?.gcount}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  RowComponent(var data, var value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              data.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          Expanded(
            child: Text(
              value.toString(),
              style: TextStyle(color: Colors.white, fontSize: 16),
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
        await InternetCheck()
            ? GrievanceUserDetails()
            : AlertsNetwork.showAlertDialog(
                context,
                TextConstants.internetcheck,
                onpressed: () {
                  Navigator.pop(context);
                },
                buttontext: TextConstants.ok,
              );
      },
    );
  }

  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  void GrievanceUserDetails() async {
    EasyLoading.show();
    var modeid = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.userdetails);
    var uid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);

    var typeid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.typeid);
    var slftype = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.grievanceDashboard);
    var emp_name =
        await SharedPreferencesClass().readTheData(PreferenceConstants.name);
    var designation = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.designation);
    var sourcename =
        await SharedPreferencesClass().readTheData(PreferenceConstants.cname);
    //print(sourcename);
    setState(() {
      name = emp_name;
      desig = designation;
      employee_level = typeid;
      source_name = sourcename;
    });
    //creating request url with base url and endpoint
    const requesturl = ApiConstants.baseurl + ApiConstants.userdetails_endpoint;

    //creating payload because request type is POST
    var requestPayload = {
      "userid": AppConstants.userid,
      "password": AppConstants.password,
      "uid": uid,
      "mode": modeid,
      "type_id": typeid,
      "slftype": slftype
    };

    //no headers and authorization

    //creating dio object in order to connect package to server
    final dioObject = Dio();

    try {
      final response = await dioObject.post(
        requesturl,
        data: requestPayload,
      );

      //converting response from String to json
      final data = UserDetailsResponse.fromJson(response.data);
      //print(response.data);
      EasyLoading.dismiss();
      setState(() {
        if (data.status == "true") {
          if (data.dashboard != null && data.dashboard!.length > 0) {
            userDetailsResponse = data;
          }
        }
      });
    } on DioError catch (e) {
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
  }
// step 5: print the response
}
