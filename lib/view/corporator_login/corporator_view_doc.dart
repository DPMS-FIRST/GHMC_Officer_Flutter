import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmcofficerslogin/model/corporator/corporator_report_req.dart';
import 'package:ghmcofficerslogin/model/corporator/corporator_report_response.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/button.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/components/textwidget.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';
import 'package:ghmcofficerslogin/view/image_view.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class CorporatorViewDoc extends StatefulWidget {
  const CorporatorViewDoc({super.key});

  @override
  State<CorporatorViewDoc> createState() => _CorporatorViewDocState();
}

class _CorporatorViewDocState extends State<CorporatorViewDoc> {
  CorporatorReportResponse? _corporatorReportResponse;

  TextEditingController _dateController = TextEditingController();
  bool date = false;
  FocusNode myFocusNode = new FocusNode();
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
        title: Text(
          "Reports",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(children: <Widget>[
        BgImage(imgPath: ImageConstants.bg),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: TextWidget(
                          text: "Date",
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          textcolor: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                    Expanded(
                      flex: 4,
                      child: TextField(
                        controller: _dateController,
                        readOnly: true,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                          onPressed: () async {
                            final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (selectedDate != null) {
                              initializeDateFormatting('es');
                              String formattedDate =
                                  DateFormat.yMd('es').format(selectedDate);
                              print("formatted date ${formattedDate}");
                              //DateFormat('dd/MM/yyyy').format(selectedDate);
                              setState(() {
                                _dateController.text = formattedDate;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.calendar_month,
                            color: Colors.blueAccent,
                          ),
                        )),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Card(
                  color: Colors.transparent,
                  child: textButton(
                      text: TextConstants.exportpdf,
                      textcolor: Colors.white,
                      onPressed: () async {
                        if (await InternetCheck()) {
                          await getCorporatorReportDetails();
                        } else {
                          AlertsNetwork.showAlertDialog(
                              context, TextConstants.internetcheck,
                              onpressed: () {
                            Navigator.pop(context);
                          }, buttontext: TextConstants.ok);
                        }
                      }),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    var cdate = DateTime.now();
    initializeDateFormatting('es');
    var dateformtter = DateFormat.yMd('es').format(cdate);
    setState(() {
      _dateController.text = dateformtter;
    });
  }

  getCorporatorReportDetails() async {
    EasyLoading.show();
    var menuId =
        await SharedPreferencesClass().readTheData(PreferenceConstants.menuId);
    var ward =
        await SharedPreferencesClass().readTheData(PreferenceConstants.ward);

    //creating request url with base url and endpoint
    // https: //19cghmc.cgg.gov.in/myghmcwebapi/Grievance/CorporatorList
    const requesturl = ApiConstants.uatBaseUrl + ApiConstants.corporatorReport;

    //creating payload because request type is POST
    CorporatorReportRequest corporatorReportRequest =
        new CorporatorReportRequest();

    corporatorReportRequest.fROMDATE = _dateController.text;
    corporatorReportRequest.tODATE = _dateController.text;
    corporatorReportRequest.mENUID = menuId;
    corporatorReportRequest.wARD = ward;
    corporatorReportRequest.tYPE = "pdf";
    var requestPayload = corporatorReportRequest.toJson();

    print(requestPayload);

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
      final data = CorporatorReportResponse.fromJson(response.data);
      print("doc response ${response.data}");
      EasyLoading.dismiss();
      if (data.status == "sucess") {
        setState(() {
          _corporatorReportResponse = data;
        });

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ImageViewPage(
                      filePath: "${_corporatorReportResponse?.filePath}",
                      filename: "${_corporatorReportResponse?.fileName}",
                    )));
        print("file ====== ${_corporatorReportResponse?.filePath}");
      } else if (data.status == 'false') {
        setState(() {
          _corporatorReportResponse = data;
        });
        AlertWithOk.showAlertDialog(context, "${data.tag}", onpressed: () {
          Navigator.pop(context);
        }, buttontext: "Ok", buttontextcolor: Colors.teal);
      } else {
        setState(() {
          _corporatorReportResponse = data;
        });
        AlertWithOk.showAlertDialog(context, "${data.tag}", onpressed: () {
          Navigator.pop(context);
        }, buttontext: "Ok", buttontextcolor: Colors.teal);
      }
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
                Navigator.pop(context,);
              });
        },
      );

      print("error is $e");

      //print("status code is ${e.response?.statusCode}");
    }
// step 5: print the response
  }
}
