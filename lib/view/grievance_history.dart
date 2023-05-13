import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ghmcofficerslogin/model/history_response.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/button.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class GrievanceHistory extends StatefulWidget {
  const GrievanceHistory({super.key});

  @override
  State<GrievanceHistory> createState() => _GrievanceHistoryState();
}

class _GrievanceHistoryState extends State<GrievanceHistory> {
  StreamSubscription? connection;
  bool isoffline = false;
  GrievanceHistoryResponse? grievanceHistoryResponse;

  String? _currentAddress;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  bool enabledropdown = false;
  bool comments = false;
  bool directions = false;
  Position? _currentPosition;
  String? long;
  String? lat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          TextConstants.grievance_history,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          BgImage(imgPath: ImageConstants.bg),
          Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount:
                          grievanceHistoryResponse?.grievance?.length ?? 0,
                      itemBuilder: (context, index) {
                        final details =
                            grievanceHistoryResponse?.grievance?[index];

                        var splitted_latlong = details?.latlon?.split(",");

                        lat = splitted_latlong?[0];

                        long = splitted_latlong?[1];

                        if (grievanceHistoryResponse?.grievanceFlag == "true" &&
                            grievanceHistoryResponse?.commentsFlag == "true") {
                          if (grievanceHistoryResponse!.comments!.isNotEmpty &&
                              details?.latlon != "0.0,0.0") {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                directions = true;
                                comments = true;
                              });
                            });
                          } else if (grievanceHistoryResponse!
                                  .comments!.isNotEmpty &&
                              details?.latlon == "0.0,0.0") {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                directions = false;
                                comments = true;
                              });
                            });
                          }
                        } else if (grievanceHistoryResponse?.commentsFlag ==
                            "true") {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (grievanceHistoryResponse!
                                .comments!.isNotEmpty) {
                              setState(() {
                                comments = true;
                              });
                            } else {
                              setState(() {
                                comments = false;
                              });
                            }

                            // Add Your Code here.
                          });
                        } else if (grievanceHistoryResponse?.grievanceFlag ==
                            "true") {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (details?.latlon == "0.0,0.0") {
                              setState(() {
                                directions = false;
                              });
                            } else {
                              setState(() {
                                directions = true;
                              });
                            }
                          });
                        }
                        return Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black87, width: 1),
                            ),
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                RowComponent(
                                  TextConstants.id,
                                  details?.id,
                                ),
                                RowComponent(
                                  TextConstants.type,
                                  details?.type,
                                ),
                                RowComponent(
                                  TextConstants.time,
                                  details?.timeStamp,
                                ),
                                RowComponents(TextConstants.mobile_number,
                                    details?.mobileno,
                                    ico: IconButton(
                                        onPressed: () {
                                          launch("tel:${details?.mobileno}");
                                        },
                                        icon: Icon(
                                          Icons.call,
                                          color:
                                              Color.fromARGB(255, 40, 133, 43),
                                        ))),
                                RowComponent(
                                  TextConstants.status,
                                  details?.status,
                                ),
                                RowComponent(
                                  TextConstants.posted_by,
                                  details?.userName,
                                ),
                                RowComponent(
                                  TextConstants.landmark,
                                  details?.landmark,
                                ),
                                RowComponent(
                                  TextConstants.remarks,
                                  details?.remarks,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    setImage(
                                      details!.photo,
                                      onTap: () {
                                        if (details.photo!.contains('.pdf')) {
                                          _pdfViewerKey.currentState
                                              ?.openBookmarkView();
                                          showAlert(details.photo);
                                        } else if (details.photo!
                                                .contains('.jpg') ||
                                            details.photo!.contains('.png') ||
                                            details.photo!.contains('.jpeg')) {
                                          showAlertImage(details.photo);
                                        }
                                      },
                                    ),
                                    setImage(
                                      details.photo2,
                                      onTap: () {
                                        if (details.photo2!.contains('.pdf')) {
                                          _pdfViewerKey.currentState
                                              ?.openBookmarkView();
                                          showAlert(details.photo2);
                                        } else if (details.photo2!
                                                .contains('.jpg') ||
                                            details.photo2!.contains('.png') ||
                                            details.photo2!.contains('.jpeg')) {
                                          showAlertImage(details.photo2);
                                        }
                                      },
                                    ),
                                    setImage(
                                      details.photo3,
                                      onTap: () {
                                        if (details.photo3!.contains('.pdf')) {
                                          _pdfViewerKey.currentState
                                              ?.openBookmarkView();
                                          showAlert(details.photo3);
                                        } else if (details.photo3!
                                                .contains('.jpg') ||
                                            details.photo3!.contains('.png') ||
                                            details.photo3!.contains('.jpeg')) {
                                          showAlertImage(details.photo3);
                                        }
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ));
                      })),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                directions
                    ? Expanded(
                        flex: 1,
                        child: Container(
                          //width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.09,
                          child: Card(
                            color: Colors.transparent,
                            child: textButton(
                              text: TextConstants.view_directions,
                              textcolor: Colors.white,
                              onPressed: () {
                                double lattitude = double.parse(lat.toString());
                                double longitude =
                                    double.parse(long.toString());
                                _launchMapsUrl(lattitude, longitude);
                              },
                            ),
                          ),
                        ),
                      )
                    : Text(""),
                comments
                    ? Expanded(
                        flex: 1,
                        child: Container(
                          //  width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.09,
                          child: Card(
                            color: Colors.transparent,
                            child: Center(
                              child: textButton(
                                text: TextConstants.view_comments,
                                textcolor: Colors.white,
                                onPressed: () async {
                                  Navigator.pushNamed(
                                      context, AppRoutes.viewcomment);
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    : Text(""),
                Expanded(
                  flex: 1,
                  child: Container(
                    // width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.09,
                    child: Card(
                      color: Colors.transparent,
                      child: textButton(
                        text: TextConstants.take_action,
                        textcolor: Colors.white,
                        onPressed: () async {
                          Navigator.pushNamed(context, AppRoutes.takeactionnew);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showAlert(String? photo) async {
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
    //showDialog
  }

  showAlertImage(String? photo) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            actions: [
              Center(
                  child: Container(
                      child: Image.network(
                photo!,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(ImageConstants.no_uploaded);
                },
              ))),
            ],
          );
        });
  }

  RowComponent(var data, var value, {IconButton? ico}) {
    //final void Function()? onpressed;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
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
          SizedBox(
            width: 10,
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
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
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
          SizedBox(
            width: 10,
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

  setImage(_backgroundImage, {void Function()? onTap}) {
    if (_backgroundImage.contains('.pdf')) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Image.asset(
            ImageConstants.viewimage,
            width: 80,
            height: 60,
          ),
        ),
      );
    }
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
              }, buttontext: TextConstants.ok,);
      },
    );
  }

  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  fetchDetails() async {
    EasyLoading.show();
    var compid = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.historydetails);
    var uid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
//creating request url with base url and endpoint
    const requesturl = ApiConstants.baseurl + ApiConstants.history_endpoint;
    //creating payload because request type is POST
    var requestPayload = {
      "userid": AppConstants.userid,
      "password": AppConstants.password,
      "compId": compid,
      "Uid": uid
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
      final data = GrievanceHistoryResponse.fromJson(response.data);
      //print(response.data);
      EasyLoading.dismiss();
      setState(() {
        if (data.status == "success") {
          if (data.grievance != null && data.grievance!.length > 0) {
            grievanceHistoryResponse = data;
          }
        }
      });

      print(
          " grivance latlon ${grievanceHistoryResponse?.grievance![0].latlon}");
      var split = grievanceHistoryResponse?.grievance?[0].latlon?.split(",");
      print(split?[0]);
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
// step 5: print the response
  }

//handling permissions
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services adre disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

//get current location
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    double lattitude = double.parse(lat.toString());
    double longitude = double.parse(long.toString());
    // 2.0

    // await placemarkFromCoordinates(
    //         _currentPosition!.latitude, _currentPosition!.longitude)
    await placemarkFromCoordinates(lattitude, longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      Placemark area = placemarks[1];
      print(area.locality);
      setState(() {
        _currentAddress =
            ' ${place.street}, ${place.subLocality}, ${place.locality},${place.administrativeArea}, ${place.postalCode},';
      });
      print("address : ${_currentAddress}");
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
