import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmcofficerslogin/model/grievance_details_response.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/button.dart';
import 'package:ghmcofficerslogin/res/components/image_view.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/row_component.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class GrievanceDetails extends StatefulWidget {
  const GrievanceDetails({
    super.key,
  });

  @override
  State<GrievanceDetails> createState() => _GrievanceDetailsState();
}

class _GrievanceDetailsState extends State<GrievanceDetails> {
  GrievanceDetailsResponse? _grievanceDetailsResponse;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  List<Comments>? commentsList;
  bool commentsbutton = false;
  bool postbutton = false;
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
              onPressed: (() {
                Navigator.of(context).pop();
              })
              //() => Navigator.of(context).pop(),
              ),
          title: Center(
            child: Text(
              "Grievance Details",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            BgImage(imgPath: ImageConstants.bg),
            ListView.builder(
                itemCount: _grievanceDetailsResponse?.grievance?.length ?? 0,
                itemBuilder: ((context, index) {
                  final details = _grievanceDetailsResponse?.grievance?[index];
                  if (_grievanceDetailsResponse?.comments != null &&
                      _grievanceDetailsResponse!.comments!.length > 0) {
                    if (_grievanceDetailsResponse?.comments?[index].flag !=
                        "false") {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          commentsbutton = true;
                        });
                      });
                    } else {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          commentsbutton = false;
                        });
                      });
                    }
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            color: Colors.white,
                            child: Column(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  checkStatusRowComponent(
                                      TextConstants.grievance_details_id,
                                      details?.id),
                                  Line(),
                                  checkStatusRowComponent(
                                      TextConstants.grievance_details_type,
                                      details?.type),
                                  Line(),
                                  checkStatusRowComponent(
                                      TextConstants.grievance_details_landmark,
                                      details?.landmark),
                                  Line(),
                                  checkStatusRowComponent(
                                      TextConstants.grievance_details_mobile,
                                      details?.mobileno),
                                  Line(),
                                  checkStatusRowComponent(
                                      TextConstants.grievance_details_time,
                                      details?.timeStamp),
                                  Line(),
                                  checkStatusRowComponent(
                                      TextConstants.grievance_details_status,
                                      details?.status),
                                  Line(),
                                  checkStatusRowComponent(
                                      TextConstants.grievance_details_status,
                                      details?.status),
                                  Line(),
                                  checkStatusRowComponent(
                                      TextConstants.grievance_details_postedby,
                                      details?.userName),
                                  Line(),
                                  checkStatusRowComponent(
                                      TextConstants.grievance_details_remarks,
                                      details?.remarks),
                                  Line(),
                                  checkStatusRowComponent(
                                      TextConstants
                                          .grievance_details_assignedto,
                                      details?.assignedto),
                                ])),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          setImage(
                            details!.photo,
                            onTap: () {
                              if (details.photo!.contains('.pdf')) {
                                _pdfViewerKey.currentState?.openBookmarkView();
                                showPdfAlert(details.photo);
                              } else if (details.photo!.contains('.jpg') ||
                                  details.photo!.contains('.png') ||
                                  details.photo!.contains('.jpeg')) {
                                showAlertImage(details.photo, context);
                              }
                            },
                          ),
                          setImage(
                            details.photo2,
                            onTap: () {
                              if (details.photo2!.contains('.pdf')) {
                                _pdfViewerKey.currentState?.openBookmarkView();
                                showPdfAlert(details.photo);
                              } else if (details.photo2!.contains('.jpg') ||
                                  details.photo2!.contains('.png') ||
                                  details.photo2!.contains('.jpeg')) {
                                showAlertImage(details.photo2, context);
                              }
                            },
                          ),
                          setImage(
                            details.photo3,
                            onTap: () {
                              if (details.photo3!.contains('.pdf')) {
                                _pdfViewerKey.currentState?.openBookmarkView();
                                showPdfAlert(details.photo);
                              } else if (details.photo3!.contains('.jpg') ||
                                  details.photo3!.contains('.png') ||
                                  details.photo3!.contains('.jpeg')) {
                                showAlertImage(details.photo3, context);
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          commentsbutton
                              ? Expanded(
                                  flex: 1,
                                  child: Card(
                                    color: Colors.transparent,
                                    child: Center(
                                      child: textButton(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        text: TextConstants.view_comments,
                                        textcolor: Colors.white,
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              AppRoutes.checkstatuscomments,
                                              arguments: commentsList);
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              : Text(""),
                          Expanded(
                            flex: 1,
                            child: Card(
                              color: Colors.transparent,
                              child: Center(
                                child: textButton(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  text: TextConstants
                                      .grievance_details_postcomment,
                                  textcolor: Colors.white,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.postcomment);
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                })),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await InternetCheck()
            ? fetchGrievanceDetails()
            : AlertsNetwork.showAlertDialog(
                context, TextConstants.internetcheck, onpressed: () {
                Navigator.pop(context);
              }, buttontext: TextConstants.ok,);
      },
    );
  }

  Line() {
    return Divider(
      thickness: 1.0,
      color: Colors.grey,
    );
  }

  showPdfAlert(String? photo) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SfPdfViewer.network(
            photo!,
            onDocumentLoadFailed: ((details) {
              print("not working");
            }),
            key: _pdfViewerKey,
          );
        });
  }

  fetchGrievanceDetails() async {
    EasyLoading.show();
    var mobileno = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.mobileno);
    var compid = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.check_status_id);
    final url = ApiConstants.baseurl + ApiConstants.grievance_details_endpoint;
    final payload = {
      "userid": AppConstants.userid,
      "password": AppConstants.password,
      "MobileNo": mobileno,
      "CompId": compid
    };
    print("payload ${payload}");
    final dioObject = Dio();
    try {
      final response = await dioObject.post(
        url,
        data: payload,
      );

      final data = GrievanceDetailsResponse.fromJson(response.data);
      _grievanceDetailsResponse = data;
      EasyLoading.dismiss();
      setState(() {
        if (data.status == "success") {
          if (_grievanceDetailsResponse?.comments != null) {
            commentsList = _grievanceDetailsResponse?.comments;
          }
        }
      });
    } on DioError catch (e) {
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
