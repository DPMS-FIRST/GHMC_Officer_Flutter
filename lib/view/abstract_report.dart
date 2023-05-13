import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmcofficerslogin/model/abstract_report_response.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';

class AbstractReport extends StatefulWidget {
  const AbstractReport({super.key});

  @override
  State<AbstractReport> createState() => _AbstractReportState();
}

class _AbstractReportState extends State<AbstractReport> {
  AbstractReportResponse? abstractReportResponse;
  List type = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          TextConstants.abstract_report,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          BgImage(imgPath: ImageConstants.bg),
          Column(
            children: [
              RowComponent(
                  "Grievances Registered",
                  abstractReportResponse?.tOTALRECEIVED ?? '',
                  Color.fromARGB(255, 113, 234, 176)),
              RowComponent(
                  "Grievances Redressed",
                  abstractReportResponse?.tOTALCLOSED ?? '',
                  Color.fromARGB(255, 157, 194, 253)),
              RowComponent(
                  "Grievances Under Process",
                  abstractReportResponse?.tOTALUNDERPROCESS ?? '',
                  Color.fromARGB(255, 245, 178, 139)),
              RowComponent(
                  "Grievances Pending",
                  abstractReportResponse?.tOTALPENDING ?? '',
                  Color.fromARGB(255, 247, 211, 140)),
              RowComponent(
                  "Grievances Non GHMC",
                  abstractReportResponse?.tOTALNONGHMC ?? '',
                  Color.fromARGB(212, 236, 239, 241)),
              RowComponent(
                  "Grievances Fund Related",
                  abstractReportResponse?.tOTALFUNDRELATED ?? '',
                  Color.fromARGB(255, 208, 164, 205)),
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // NetCheck();
    fetchDetails();
  }

  fetchDetails() async {
    var uid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
    var typeid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.typeid);

//creating request url with base url and endpoint
    const requesturl =
        ApiConstants.baseurl + ApiConstants.abstract_report_endpoint;
    //creating payload because request type is POST
    var requestPayload = {
      "userid": AppConstants.userid,
      "password": AppConstants.password,
      "uid": uid,
      "type_id": typeid,
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

      final data = AbstractReportResponse.fromJson(response.data);
      // print(response.data);

      setState(() {
        if (data.status == "true") {
          EasyLoading.dismiss();
          abstractReportResponse = data;
        }
      });
    } on DioError catch (e) {
      EasyLoading.dismiss();

      return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SingleButtonDialogBox(
              bgColor: Color.fromARGB(255, 225, 38, 38),
              descriptions: "Network is busy.",
              img: Image.asset(ImageConstants.cross),
              onPressed: () {
                Navigator.pop(context);
              });
        },
      );

      //print("status code is ${e.response?.statusCode}");
    }
// step 5: print the response
  }

  RowComponent(var data, var value, var color) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Card(
        /* color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
                  [Random().nextInt(2) * 100], */
        color: color,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ListTile(
            leading: Image.asset(
              "assets/file.png",
              height: 25.0,
            ),
            title: Column(
              children: [
                Text(
                  data.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  value.toString(),
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* class AbstractReport extends StatelessWidget {
  AbstractReport({super.key});
  final _random = Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          TextConstants.abstract_report,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          BgImage(imgPath: ImageConstants.bg),
          ListView.builder(
            itemCount: 6,
            itemBuilder:(context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical:4.0, horizontal: 8.0),
                child: Card(
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
                  [Random().nextInt(2) * 100], 
                  shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(10.0) ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60.0,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ListTile(
                         leading: Icon(Icons.person),
                         title: Column(
                          children: [
                              Text("Lavanya",
                              style: TextStyle(
                                color: Colors.black
                              ),
                              ),
                              Text("Lavanya",
                              style: TextStyle(
                                color: Colors.black
                              ),
                              )
                          ],
                         ),
                        ),
                        ),
                    ),
                ),
              );
              
            },)
        ],
      ),
    );
  }
   */


  
