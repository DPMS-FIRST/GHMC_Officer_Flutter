import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmcofficerslogin/model/raise_grievance_response.dart';
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

class RaiseGrievance extends StatefulWidget {
  const RaiseGrievance({super.key});

  @override
  State<RaiseGrievance> createState() => _RaiseGrievanceState();
}

class _RaiseGrievanceState extends State<RaiseGrievance> {
  raiseGrievanceResponse? _grievanceResponse;
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
                Navigator.pushNamed(context, AppRoutes.ghmcdashboard);
              },
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Center(
            child: Text(
              "Grievance Types",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Stack(
          children: [
            BgImage(imgPath: ImageConstants.bg),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: GridView.builder(
                    itemCount: _grievanceResponse?.rOW?.length ?? 0,
                    itemBuilder: (context, index) {
                      final data = _grievanceResponse?.rOW?[index];
                      return GestureDetector(
                        onTap: () async {
                          EasyLoading.show();
                          await SharedPreferencesClass().writeTheData(
                              PreferenceConstants.grievance_type,
                              data?.gRIEVANCEID);
                          Navigator.pushNamed(context, AppRoutes.newcomplaint);
                        },
                        child: Column(
                          children: [
                            Image.network(
                              "${data?.iURL}",
                              height: 50,
                            ),
                            // SizedBox(
                            //   height: 5.0,
                            // ),
                            Text(
                              "${data?.cNAME}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2,
                    ),
                  ),
                ),
              ],
            ),
          ],
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
        ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await InternetCheck()
            ? raiseGrievanceDetails()
            : AlertsNetwork.showAlertDialog(
                context, TextConstants.internetcheck, onpressed: () {
                Navigator.pop(context);
              }, buttontext: TextConstants.ok,);
      },
    );
  }

  raiseGrievanceDetails() async {
    EasyLoading.show();
    var no = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.mobileno);
    print("number ${no}");
    final raise_grievance_url =
        ApiConstants.baseurl + ApiConstants.raise_grievance_endpoint;
    final raise_grievance_payload = {
      "userid": AppConstants.userid,
      "password": AppConstants.password
    };
    final dio_obj = Dio();
    try {
      final raise_grievance_response = await dio_obj.post(raise_grievance_url,
          data: raise_grievance_payload);
      print(raise_grievance_response.data);
      final data =
          raiseGrievanceResponse.fromJson(raise_grievance_response.data);
      EasyLoading.dismiss();
      setState(() {
        if (data.rOW != null) {
          _grievanceResponse = data;
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
