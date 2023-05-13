import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmcofficerslogin/model/check_status_response.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/searchbar.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/components/textwidget.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';
import 'package:supercharged/supercharged.dart';

class Check extends StatefulWidget {
  const Check({super.key});

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  checkStatusResponse? _statusResponse;
  Set<String> headings = {};
  var res;
  List totalitems = [];
  List<ViewGrievances>? _list;
  Map<String, String> objects = {};
  bool searchflag = false;
  var searchheads = [];
  var searchvalues;
  var searchdays;
  var ticketlistResponse;
  var ticketlistSearchListResponse;
  List titles = [
    TextConstants.checkstatus_stepper_open,
    TextConstants.checkstatus_stepper_underprocess,
    TextConstants.checkstatus_stepper_resolvedbyofficer,
    TextConstants.checkstatus_stepper_closedbycitizen,
    TextConstants.checkstatus_stepper_conditionclosed
  ];

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
        title: Center(
          child: Text(
            "Check Status",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ),
      body: Stack(children: <Widget>[
        BgImage(imgPath: ImageConstants.bg),
        Column(
          children: [
            ReusableSearchbar(
              hinttext: 'Search by Id/Category/SubCategory',
              bgColor: Colors.white,
              screenHeight: 0.05,
              searchIcon: Icon(Icons.search),
              topPadding: 8.0,
              onChanged: ((value) {
                _runFilter(value);
              }),
              screenWidth: 1,
              onPressed: () {},
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: searchflag
                                ? searchheads.length
                                : headings
                                    .length /*  res
                                
                                .keys
                                .toList()
                                .length */
                            ,
                            itemBuilder: (BuildContext context, int index1) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    color: Color.fromARGB(255, 20, 55, 83),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          searchflag
                                              ? Text(
                                                  "${searchheads[index1]}",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                )
                                              : Text(
                                                  res.keys.toList()[index1],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                          searchflag
                                              ? Text(
                                                  "${searchvalues[index1].length}",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                )
                                              : Text(
                                                  "${res.values.toList()[index1].length}",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                      itemCount: searchflag
                                          ? searchvalues[index1].length
                                          : res.values.toList()[index1].length,
                                      physics: ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index2) {
                                        int resdays = noOfDaysCalculation(
                                            res.values.toList()[index1][index2][
                                                TextConstants
                                                    .check_status_time_stamp]);

                                        return GestureDetector(
                                          onTap: (() {
                                            SharedPreferencesClass().writeTheData(
                                                PreferenceConstants
                                                    .check_status_id,
                                                searchflag
                                                    ? searchvalues[index1]
                                                            [index2][
                                                        TextConstants
                                                            .check_status_id]
                                                    : res.values.toList()[
                                                            index1][index2][
                                                        TextConstants
                                                            .check_status_id]);

                                            Navigator.pushNamed(context,
                                                AppRoutes.grivancedetails);
                                          }),
                                          child: Container(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RowComponent(
                                                  TextConstants.check_status_id,
                                                  searchflag
                                                      ? searchvalues[index1]
                                                              [index2][
                                                          TextConstants
                                                              .check_status_id]
                                                      : res.values.toList()[
                                                              index1][index2][
                                                          TextConstants
                                                              .check_status_id]),
                                              Line(),
                                              RowComponent(
                                                  TextConstants
                                                      .check_status_category_name,
                                                  searchflag
                                                      ? searchvalues[index1]
                                                              [index2][
                                                          TextConstants
                                                              .check_status_category_name]
                                                      : res.values.toList()[
                                                              index1][index2][
                                                          TextConstants
                                                              .check_status_category_name]),
                                              Line(),
                                              RowComponent(
                                                  TextConstants
                                                      .check_status_subcategory_name,
                                                  searchflag
                                                      ? searchvalues[index1]
                                                              [index2][
                                                          TextConstants
                                                              .check_status_subcategory_name]
                                                      : res.values.toList()[
                                                              index1][index2][
                                                          TextConstants
                                                              .check_status_subcategory_name]),
                                              Line(),
                                              RowComponent(
                                                  TextConstants
                                                      .check_status_assigned_to,
                                                  searchflag
                                                      ? searchvalues[index1]
                                                              [index2][
                                                          TextConstants
                                                              .check_status_assigned_to]
                                                      : res.values.toList()[
                                                              index1][index2][
                                                          TextConstants
                                                              .check_status_assigned_to]),
                                              Line(),
                                              // time stamp
                                              RowComponent(
                                                  TextConstants
                                                      .check_status_status,
                                                  searchflag
                                                      ? searchvalues[index1]
                                                                  [index2][
                                                              TextConstants
                                                                  .check_status_status] +
                                                          "  (${searchvalues[index1][index2][TextConstants.check_status_noofdays]} days)"
                                                      : res.values.toList()[
                                                                      index1]
                                                                  [index2][
                                                              TextConstants
                                                                  .check_status_status] +
                                                          "  (${res.values.toList()[index1][index2][TextConstants.check_status_noofdays]} days)"),

                                              Line(),
                                              Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 10.0),
                                                  child: Container(
                                                      // width: this._width,
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    25.0),
                                                        child: Row(
                                                          children: _iconViews(
                                                              status: searchflag
                                                                  ? searchvalues[
                                                                              index1]
                                                                          [
                                                                          index2]
                                                                      [
                                                                      TextConstants
                                                                          .check_status_status]
                                                                  : res.values.toList()[
                                                                              index1]
                                                                          [
                                                                          index2]
                                                                      [
                                                                      TextConstants
                                                                          .check_status_status]),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        children: _titleViews(),
                                                      ),
                                                    ],
                                                  ))),
                                              Line(),
                                            ],
                                          )),
                                        );
                                      }),
                                ],
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await InternetCheck()
            ? checkStatusDetails()
            : AlertsNetwork.showAlertDialog(
                context, TextConstants.internetcheck, onpressed: () {
                Navigator.pop(context);
              }, buttontext: TextConstants.ok);
      },
    );
  }

  _runFilter(String enteredKeyword) {
    setState(() {
      searchflag = true;
    });
    // print("object");

    var results = [];
    var finalitems;

    if (enteredKeyword.isEmpty) {
      finalitems = ticketlistResponse;
    } else {
      ticketlistResponse.map((user) {
        user.map((u) {
          if (u[TextConstants.check_status_id].contains(enteredKeyword) ||
              u[TextConstants.check_status_subcategory_name]
                  .toLowerCase()
                  .contains(enteredKeyword) ||
              u[TextConstants.check_status_subcategory_name]
                  .toUpperCase()
                  .contains(enteredKeyword) ||
              u[TextConstants.check_status_subcategory_name]
                  .contains(enteredKeyword) ||
              u[TextConstants.check_status_category_name]
                  .toLowerCase()
                  .contains(enteredKeyword) ||
              u[TextConstants.check_status_category_name]
                  .toUpperCase()
                  .contains(enteredKeyword) ||
              u[TextConstants.check_status_category_name]
                  .contains(enteredKeyword)) {
            print(
                "category nme ${u[TextConstants.check_status_category_name]}");
            print("timeeeeeeee ${u[TextConstants.check_status_time_stamp]}");
            // print(user);

            results.add(u);
          }
        }).toList();
      }).toList();

      finalitems = results.groupBy(
          (element) => element[TextConstants.check_status_subcategory_name]);

      setState(() {
        ticketlistSearchListResponse = finalitems;
      });

      searchheads = ticketlistSearchListResponse.keys.toList();

      searchvalues = ticketlistSearchListResponse.values.toList();
      print("searchvalues ${searchvalues}");
    }
  }

  checkStatusDetails() async {
    EasyLoading.show();
    var mobileno = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.mobileno);

    final check_status_url =
        ApiConstants.baseurl + ApiConstants.check_status_endpoint;
    print("check status requesturl ::::: ${check_status_url}");
    final check_status_payload = {
      "mobileno": mobileno,
      "password": AppConstants.password,
      "userid": AppConstants.userid
    };

    print("check status payload ::::: ${check_status_payload}");
    final dio_obj = Dio();
    // print("payload ${check_status_payload}");

    try {
      final check_status_response =
          await dio_obj.post(check_status_url, data: check_status_payload);

      print("check status response ::::: ${check_status_response}");

      final data = checkStatusResponse.fromJson(check_status_response.data);
      EasyLoading.dismiss();
      if (data.status == "success") {
        setState(() {
          _statusResponse = data;

          if (_statusResponse?.viewGrievances != null) {
            _list = _statusResponse?.viewGrievances;
            var len = _list?.length ?? 0;

            for (var i = 0; i < len; i++) {
              headings.add("${_list?[i].type}");
              var item = _list?[i];
              var dayssssss = noOfDaysCalculation(item?.timestamp ?? "");

              objects = {
                TextConstants.check_status_id: item?.id ?? "",
                TextConstants.check_status_assigned_to: item?.assignedto ?? "",
                TextConstants.check_status_category_name: item?.category ?? "",
                TextConstants.check_status_subcategory_name: item?.type ?? "",
                TextConstants.check_status_time_stamp: item?.timestamp ?? "",
                TextConstants.check_status_status: item?.status ?? "",
                TextConstants.check_status_noofdays: dayssssss.toString(),
              };
              // print(d);
              totalitems.add(objects);
            }

            res = totalitems.groupBy((element) =>
                element[TextConstants.check_status_subcategory_name]);
            print("ressss ${res}");
            ticketlistResponse = res.values.toList();
            ticketlistSearchListResponse = ticketlistResponse;
          }
        });
      } else {
        setState(() {
          _statusResponse = data;
        });
        return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return SingleButtonDialogBox(
                bgColor: Color.fromARGB(255, 202, 58, 58),
                descriptions: "${data.message}",
                img: Image.asset(ImageConstants.cross,
                    color: Color.fromARGB(255, 202, 58, 58)),
                onPressed: () {
                  Navigator.pop(context);
                });
          },
        );
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
              img: Image.asset(ImageConstants.cross,),
              onPressed: () {
                Navigator.pop(context);
              });
        },
      );
    }
  }

  RowComponent(var data, var val) {
    //final void Function()? onpressed;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 1,
              child: TextWidget(
                text: "${data}",
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                textcolor: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          Expanded(
              flex: 1,
              child: TextWidget(
                text: "${val}",
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                textcolor: Colors.blueGrey,
              ))
        ],
      ),
    );
  }

  bool openflag = false;
  bool underprocess = false;
  bool resolvedbyofficer = false;
  bool closedbycitizen = false;
  bool conditionclosed = false;

  List<Widget> _iconViews({required status}) {
    // print("check status ${status}");

    switch (status) {
      case TextConstants.checkstatus_stepper_open:
        openflag = true;
        underprocess = false;
        resolvedbyofficer = false;
        closedbycitizen = false;
        conditionclosed = false;
        // print("open ${openflag}");
        break;
      case TextConstants.checkstatus_stepper_underprocess:
        underprocess = true;
        openflag = false;
        resolvedbyofficer = false;
        closedbycitizen = false;
        conditionclosed = false;
        // print("underprocess ${underprocess}");
        break;
      case TextConstants.checkstatus_stepper_resolvedbyofficer:
        resolvedbyofficer = true;
        openflag = false;
        underprocess = false;
        closedbycitizen = false;
        conditionclosed = false;
        // print("resolvedbyofficer ${resolvedbyofficer}");
        break;
      case TextConstants.checkstatus_stepper_closedbycitizen:
        closedbycitizen = true;
        openflag = false;
        underprocess = false;
        resolvedbyofficer = false;
        conditionclosed = false;
        // print("closedbycitizen ${closedbycitizen}");
        break;
      case TextConstants.checkstatus_stepper_conditionclosed:
        conditionclosed = true;
        openflag = false;
        underprocess = false;
        resolvedbyofficer = false;
        closedbycitizen = false;
        // print("conditionclosed ${conditionclosed}");
        break;
      default:
    }

    var list = <Widget>[];
    titles.asMap().forEach((i, icon) {
      switch (i) {
        case 0:
          list.add(
            Container(
              width: 20.0,
              height: 20.0,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(22.0)),
                border: new Border.all(
                  color: openflag ? Colors.blue : Colors.black,
                  width: openflag ? 10.0 : 2.0,
                ),
              ),
            ),
          );

          break;
        case 1:
          list.add(
            Container(
              width: 20.0,
              height: 20.0,
              decoration: new BoxDecoration(
                // color: circleColor,
                borderRadius: new BorderRadius.all(new Radius.circular(22.0)),
                border: new Border.all(
                  color: underprocess ? Colors.orange : Colors.black,
                  width: underprocess ? 10.0 : 2.0,
                ),
              ),
            ),
          );
          break;
        case 2:
          list.add(
            Container(
              width: 20.0,
              height: 20.0,
              decoration: new BoxDecoration(
                // color: circleColor,
                borderRadius: new BorderRadius.all(new Radius.circular(22.0)),
                border: new Border.all(
                  color: resolvedbyofficer
                      ? Color.fromARGB(255, 56, 126, 58)
                      : Colors.black,
                  width: resolvedbyofficer ? 10.0 : 2.0,
                ),
              ),
            ),
          );
          break;
        case 3:
          list.add(
            Container(
              width: 20.0,
              height: 20.0,
              padding: EdgeInsets.all(0),
              decoration: new BoxDecoration(
                // color: circleColor,
                borderRadius: new BorderRadius.all(new Radius.circular(22.0)),
                border: new Border.all(
                  color: closedbycitizen
                      ? Color.fromARGB(255, 37, 110, 38)
                      : Colors.black,
                  width: closedbycitizen ? 10.0 : 2.0,
                ),
              ),
            ),
          );
          break;
        case 4:
          list.add(
            Container(
              width: 20.0,
              height: 20.0,
              padding: EdgeInsets.all(0),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(22.0)),
                border: new Border.all(
                  color: conditionclosed
                      ? Color.fromARGB(255, 104, 22, 16)
                      : Colors.black,
                  width: conditionclosed ? 10.0 : 2.0,
                ),
              ),
            ),
          );
          break;

        default:
          list.add(
            Container(
              width: 20.0,
              height: 20.0,
              padding: EdgeInsets.all(0),
              decoration: new BoxDecoration(
                // color: circleColor,
                borderRadius: new BorderRadius.all(new Radius.circular(22.0)),
                border: new Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),

              /* child: Icon(
            Icons.radio_button_off_outlined,
            color: Colors.black,
            size: 20.0,
          ), */
            ),
          );
          break;
      }
      //line between icons
      if (i != titles.length - 1) {
        list.add(Expanded(
            child: Container(
          height: 1.5,
          color: Colors.black,
        )));
      }
    });

    return list;
  }

  List<Widget> _titleViews() {
    var list = <Widget>[];
    titles.asMap().forEach((i, text) {
      list.add(Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 10,
              )),
        ),
      ));
    });
    return list;
  }

  Line() {
    return Divider(
      thickness: 1.0,
      color: Colors.grey,
    );
  }

  int noOfDaysCalculation(String date) {
    var currentdate = DateTime.now().toString().split(" ")[0];
    String originalDate = "${date.split(" ")[0]}";
    List<String> dateParts = originalDate.split("-");
    String day = dateParts[0];
    String monthAbbreviation = dateParts[1];
    String year = dateParts[2];

    Map<String, String> monthMap = {
      'JAN': "01",
      'FEB': "02",
      'MAR': "03",
      'APR': "04",
      'MAY': "05",
      'JUN': "06",
      'JUL': "07",
      'AUG': "08",
      'SEP': "09",
      'OCT': "10",
      'NOV': "11",
      'DEC': "12",
    };

    dynamic monthNumber = monthMap[monthAbbreviation];
    String newDate = '$year-$monthNumber-$day';
    DateTime startDate =
        DateTime.parse(DateTime.parse(newDate).toString().split(" ")[0]);
    DateTime endDate =
        DateTime.parse(DateTime.parse(currentdate).toString().split(" ")[0]);
    Duration difference = endDate.difference(startDate);
    int days = difference.inDays;

    return days;
  }
}
