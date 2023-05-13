import 'package:dio/dio.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/model/show_notification_response.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';

class InboxNotifications extends StatefulWidget {
  const InboxNotifications({super.key});

  @override
  State<InboxNotifications> createState() => _InboxNotificationsState();
}

class _InboxNotificationsState extends State<InboxNotifications> {
  ShowNotificationResponse? showNotificationResponse;
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
            TextConstants.notification_inbox,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Column(
                    children: [
                      Text("${showNotificationResponse?.title}"),
                      Text("${showNotificationResponse?.timestamp}"),
                      ExpandableText(
                        "${showNotificationResponse?.msg}",
                        expandText: 'show more',
                        collapseText: 'show less',
                        maxLines: 1,
                        linkColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
              );
            },
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
            ? fetchDetails()
            : AlertsNetwork.showAlertDialog(
                context, TextConstants.internetcheck, onpressed: () {
                Navigator.pop(context);
              }, buttontext: TextConstants.ok);
      },
    );
  }

  fetchDetails() async {
    EasyLoading.show();
    var mobile = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.mobileno);

    const requesturl =
        ApiConstants.baseurl + ApiConstants.inbox_notifications_endpoint;

    var payload = {
      "userid": AppConstants.userid,
      "password": AppConstants.password,
      "mobileno": mobile,
    };

    final dioObject = Dio();

    try {
      final response = await dioObject.post(requesturl, data: payload);
      var len = response.data.length;

      for (var i = 0; i < len; i++) {
        final data = ShowNotificationResponse.fromJson(response.data[i]);
        EasyLoading.dismiss();
        setState(() {
          if (data.status == "success") {
            EasyLoading.dismiss();
            showNotificationResponse = data;
          }
        });
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
