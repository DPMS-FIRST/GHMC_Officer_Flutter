import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmcofficerslogin/model/history_response.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
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
import 'package:url_launcher/url_launcher.dart';

class ViewCommentsScreen extends StatefulWidget {
  const ViewCommentsScreen({super.key});

  @override
  State<ViewCommentsScreen> createState() => _ViewCommentsScreenState();
}

class _ViewCommentsScreenState extends State<ViewCommentsScreen> {
  GrievanceHistoryResponse? grievanceHistoryResponse;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          TextConstants.view,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          BgImage(imgPath: ImageConstants.bg),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
                itemCount: grievanceHistoryResponse?.comments?.length ?? 0,
                itemBuilder: ((context, index) {
                  var item = grievanceHistoryResponse?.comments?[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black87, width: 1),
                    ),
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        RowComponent(
                          "PostedBy",
                          item?.cuserName,
                        ),
                        RowComponent(
                          "ID",
                          item?.cid,
                        ),
                        RowComponent(
                          "Status",
                          item?.cstatus,
                        ),
                        RowComponent(
                          "Time Stamp",
                          item?.ctimeStamp,
                        ),
                        RowComponent(
                          "Remarks",
                          item?.cremarks,
                        ),
                        RowComponents("Mobile", item?.cmobileno,
                            ico: IconButton(
                                onPressed: () {
                                  launch("tel:${item?.cmobileno}");
                                },
                                icon: Icon(
                                  Icons.call,
                                  color: Color.fromARGB(255, 40, 133, 43),
                                ))),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Image.network(
                            "${item?.cphoto}",
                            height: 100.0,
                            width: 100.0,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                ImageConstants.ghmc_logo_new,
                                width: 200.0,
                                height: 100.0,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }

  setImage(_backgroundImage, {void Function()? onTap}) {
    if (_backgroundImage.contains('.pdf')) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Image.asset(
            ImageConstants.viewpdf,
            width: 80,
            height: 50,
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Image.asset(
            ImageConstants.viewimage,
            width: 80,
            height: 60,
          ),
        ),
      );
    }
  }

  RowComponent(var data, var value) {
    //final void Function()? onpressed;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              data.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value.toString(),
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  RowComponents(var data, var value, {IconButton? ico}) {
    //final void Function()? onpressed;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              data.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value.toString(),
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(child: ico),
          ),
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
            ? fetchDetails()
            : AlertsNetwork.showAlertDialog(
                context, TextConstants.internetcheck, onpressed: () {
                Navigator.pop(context);
              }, buttontext: TextConstants.ok);
      },
    );
  }

  void fetchDetails() async {
    EasyLoading.show();
    var compid = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.historydetails);
    var uid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
    const url = ApiConstants.baseurl + ApiConstants.history_endpoint;
    print("grievance history url ::: ${url} ");
    final pload = {
      "userid": AppConstants.userid,
      "password": AppConstants.password,
      "compId": compid,
      "Uid": uid
    };
    print("grievance history payload::: ${pload}");
    final _dioObject = Dio();
    try {
      final _response = await _dioObject.post(url, data: pload);
      print("grievance history response::: ${_response.data}");

      final data = GrievanceHistoryResponse.fromJson(_response.data);
      EasyLoading.dismiss();
      if (data.status == "success") {
        if (data.comments != null) {
          setState(() {
            grievanceHistoryResponse = data;
          });
        } else {
          setState(() {
            grievanceHistoryResponse = data;
          });
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SingleButtonDialogBox(
                  bgColor: Color.fromARGB(255, 202, 58, 58),
                  descriptions: "No records available",
                  img: Image.asset(ImageConstants.cross,
                      color: Color.fromARGB(255, 202, 58, 58)),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.fullgrievancedetails);
                  });
            },
          );
        }
      }
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
