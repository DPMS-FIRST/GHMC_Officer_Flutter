import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/model/veternary/get_centers_response_model.dart.dart';
import 'package:ghmcofficerslogin/model/veternary/get_questionnaire_response_model.dart';
import 'package:ghmcofficerslogin/res/components/image_capture.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert.dart';
import 'package:ghmcofficerslogin/res/components/two_radiobuttons_reusable.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/providers/provider_notifiers.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/utils/base64.dart';
import 'package:image_picker/image_picker.dart';

import '../model/veternary/get_activities_response_model.dart';
import '../res/components/background_image.dart';
import '../res/components/showalert_singlebutton.dart';
import '../res/constants/Images/image_constants.dart';

class VeternaryForm extends StatefulWidget {
  const VeternaryForm({super.key});

  @override
  State<VeternaryForm> createState() => _VeternaryFormState();
}

class _VeternaryFormState extends State<VeternaryForm> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController CatchingStreetDogLocationController =
      TextEditingController();
  TextEditingController CatchingofpigsController = TextEditingController();
  TextEditingController AmountController = TextEditingController();
  TextEditingController MaterialweightController = TextEditingController();

  VgetActivitiesResponseModel? _activitiesResponseModel;
  getCentersResponseModel? _centersResponseModel;
  GetQuestionnaireResponseModel? _getQuestionnaireResponseModel;
  List<Activities>? activityDetails = [];
  List<Centers>? centerDetails = [];
  List<Questions>? questionDetails = [];
  TextEditingController? locationController;
  TextEditingController? catchingController;
  XFile imageData1 = XFile("");
  String base64_img1 = "";

  var activityId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black, // set the color of the icons
          ),
          leading: IconButton(
            onPressed: () {
              setState(() {
                getactivities.value = "select";
                actionTakenValue.value = false;
                fineComposedValue.value = false;
                materialWeightValue.value = false;

                Navigator.pop(context);
              });
            },
            icon: Icon(Icons.arrow_back),
            style: ButtonStyle(),
          ),
          title: Text(
            "Veternary Form",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Stack(
          children: [
            BgImage(imgPath: ImageConstants.bg),
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  ValueListenableBuilder(
                      valueListenable: getactivities,
                      builder: ((context, value, child) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.95,
                              decoration: BoxDecoration(color: Colors.white),
                              child: DropdownButton(
                                  underline:
                                      Container(color: Colors.transparent),
                                  // value: selectedCountry.value,
                                  hint: value == null
                                      ? Text('Please Select ')
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            value,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  dropdownColor: Colors.white,
                                  iconEnabledColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  items: activityDetails?.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val.activityName,
                                        child: Text("${val.activityName}"),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) async {
                                    setState(() {
                                      getactivities.value = val;
                                      activityDetails?.forEach((element) async {
                                        if (element.activityName ==
                                            getactivities.value) {
                                          var id = element.activityId;
                                          switch (id) {
                                            case 100001:
                                              activityId = id;
                                              await getCenters(
                                                  activityId.toString());
                                              break;
                                            case 100003:
                                              await getQuestionnaire(
                                                  id.toString());
                                              break;
                                          }
                                        }
                                      });
                                    });
                                  }),
                            ),
                          ),
                        );
                      })),
                  activityId == 100001
                      ? ValueListenableBuilder(
                          valueListenable: getcenters,
                          builder: ((context, value, child) {
                            return Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: DropdownButton(
                                      underline:
                                          Container(color: Colors.transparent),
                                      // value: selectedCountry.value,
                                      hint: value == null
                                          ? Text('Please Select ')
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                      isExpanded: true,
                                      iconSize: 30.0,
                                      dropdownColor: Colors.white,
                                      iconEnabledColor: Colors.black,
                                      style: TextStyle(color: Colors.black),
                                      items: centerDetails?.map(
                                        (val) {
                                          return DropdownMenuItem<String>(
                                            value: val.centerName,
                                            child: Text("${val.centerName}"),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (val) async {
                                        setState(() {
                                          getcenters.value = val;
                                        });
                                      }),
                                ),
                              ),
                            );
                          }))
                      : Container(),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.95,
                    color: Colors.white,
                    child: ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: questionDetails?.length,
                      itemBuilder: (context, index) {
                        var questionData = questionDetails?[index];
                        switch (questionData?.questionId) {
                          case 300007:
                            return SetUi(
                              controller: CatchingStreetDogLocationController,
                              questionId: questionData?.questionId,
                              question: questionData?.questionName,
                              questionType: questionData?.questionType,
                              isImage: questionData?.isImage,
                              inputType: questionData?.inputType,
                              maxlength: questionData?.maxLength,
                            );
                          case 300008:
                            return SetUi(
                              controller: CatchingofpigsController,
                              questionId: questionData?.questionId,
                              question: questionData?.questionName,
                              questionType: questionData?.questionType,
                              isImage: questionData?.isImage,
                              inputType: questionData?.inputType,
                              maxlength: questionData?.maxLength,
                            );
                          case 300009:
                            return SetUi(
                              radiobuttonValue: actionTakenValue,
                              questionId: questionData?.questionId,
                              question: questionData?.questionName,
                              questionType: questionData?.questionType,
                              isImage: questionData?.isImage,
                              inputType: questionData?.inputType,
                              maxlength: questionData?.maxLength,
                            );
                          case 300010:
                            return actionTakenValue.value == true
                                ? SetUi(
                                    questionId: questionData?.questionId,
                                    question: questionData?.questionName,
                                    questionType: questionData?.questionType,
                                    isImage: questionData?.isImage,
                                    inputType: questionData?.inputType,
                                    maxlength: questionData?.maxLength,
                                  )
                                : Container();
                          case 300011:
                            return actionTakenValue.value == true
                                ? SetUi(
                                    radiobuttonValue: fineComposedValue,
                                    questionId: questionData?.questionId,
                                    question: questionData?.questionName,
                                    questionType: questionData?.questionType,
                                    isImage: questionData?.isImage,
                                    inputType: questionData?.inputType,
                                    maxlength: questionData?.maxLength,
                                  )
                                : Container();
                          case 300012:
                            return fineComposedValue.value == true
                                ? SetUi(
                                    controller: AmountController,
                                    questionId: questionData?.questionId,
                                    question: questionData?.questionName,
                                    questionType: questionData?.questionType,
                                    isImage: questionData?.isImage,
                                    inputType: questionData?.inputType,
                                    maxlength: questionData?.maxLength,
                                  )
                                : Container();
                          case 300013:
                            return actionTakenValue.value == true
                                ? SetUi(
                                    radiobuttonValue: materialWeightValue,
                                    questionId: questionData?.questionId,
                                    question: questionData?.questionName,
                                    questionType: questionData?.questionType,
                                    isImage: questionData?.isImage,
                                    inputType: questionData?.inputType,
                                    maxlength: questionData?.maxLength,
                                  )
                                : Container();
                          case 300014:
                            return materialWeightValue.value == true
                                ? SetUi(
                                    controller: MaterialweightController,
                                    questionId: questionData?.questionId,
                                    question: questionData?.questionName,
                                    questionType: questionData?.questionType,
                                    isImage: questionData?.isImage,
                                    inputType: questionData?.inputType,
                                    maxlength: questionData?.maxLength,
                                  )
                                : Container();

                          default:
                            return Container();
                        }
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.92,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Card(
                      color: Colors.transparent,
                      child: ElevatedButton(
                          onPressed: () async {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent),
                          child: Text("Submit")),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  void initState() {
    EasyLoading.dismiss();

    super.initState();
    getActivities();
  }
  // ui setup
  // test

  SetUi(
      {int? questionId,
      String? question,
      String? questionType,
      String? isImage,
      String? inputType,
      String? maxlength,
      ValueNotifier<bool>? radiobuttonValue,
      TextEditingController? controller}) {
    return Container(
      child: Column(children: [
        Text(
          "${question}",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        switchCaseWidget(questionType ?? "", inputType ?? "", maxlength ?? "0",
            radiobuttonValue ?? ValueNotifier<bool>(false)),
        ImageWidget(isImage),
      ]),
    );
  }

  ImageWidget(String? isImage) {
    return isImage == "Y"
        ? ImageCapture(
            callbackValue: (imageData) {
              imageData1 = imageData;
              base64_img1 = convertToBase64(imageData1.path);
            },
          )
        : Container();
  }

  Widget switchCaseWidget(String question, String inputType, String maxlength,
      ValueNotifier<bool> radiobuttonValue) {
    Widget widget;
    switch (question) {
      case 'Date':
        widget = buildDateQuestionWidget(question);
        break;
      case 'Entry field':
        widget = buildEntryFieldQuestionWidget(question, inputType, maxlength);
        break;
      case 'Yes/No':
        widget = buildYesNoQuestionWidget(question, radiobuttonValue);
        break;
      case 'Image':
        widget = buildImageQuestionWidget(question);
        break;
      default:
        widget = SizedBox.shrink();
    }
    return widget;
  }

  TextInputType TypeInput(String? inputType) {
    switch (inputType) {
      case 'Numeric':
        return TextInputType.phone;
      case "DECIMAL":
        return TextInputType.number;

      default:
        return TextInputType.text;
    }
  }

  Widget buildDateQuestionWidget(String question) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          child: TextField(
            readOnly: true,
            controller: _dateController,
            decoration: InputDecoration(
              hintText: "__/__/__",
              border: InputBorder.none,
            ),
            onTap: () {
              // Show date picker and update the text field value
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              ).then((selectedDate) {
                if (selectedDate != null) {
                  setState(() {
                    _dateController.text = selectedDate
                        .toString()
                        .split(" ")[0]
                        .toString(); // Set the selected date to the text field
                  });
                }
              });
            },
          ),
        ),
        Icon(Icons.calendar_month)
      ],
    );
  }

  Widget buildEntryFieldQuestionWidget(
      String question, String inputType, String maxlength) {
    return Container(
      margin: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: Center(
        child: TextField(
          maxLength: int.parse(maxlength),
          keyboardType: TypeInput(inputType),
          cursorColor: Colors.black,
          decoration: InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
          controller: locationController,
        ),
      ),
    );
  }

  Widget buildYesNoQuestionWidget(
      String question, ValueNotifier<bool> radiobuttonValue) {
    return ValueListenableBuilder(
      valueListenable: radiobuttonValue,
      builder: (context, value, child) {
        return TwoRadioButtonsRow(
          option1Text: "Yes",
          option2Text: "No",
          onOption1Selected: (selected) {
            setState(() {
              radiobuttonValue.value = selected;
            });
          },
          onOption2Selected: (selected) {
            setState(() {
              radiobuttonValue.value = selected;
            });
          },
          groupValue: radiobuttonValue,
        );
      },
    );
  }

  Widget buildImageQuestionWidget(String question) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: ImageCapture(
        callbackValue: (imageData) {
          imageData1 = imageData;
          base64_img1 = convertToBase64(imageData1.path);
        },
      ),
    );
  }

  Future<void> getActivities() async {
    final getActivitiesUrl =
        ApiConstants.VeternaryBaseUrl + ApiConstants.VeternaryGetActivities;

    final empid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
    //  final userid= await SharedPreferencesClass().readTheData(PreferenceConstants.);
    print("userid ${AppConstants.userid}");

    var queryParams = {
      "EmpId": empid,
    };
    var headers = {
      "userid": AppConstants.veternaryUserid,
      "hashkey": AppConstants.veternaryHashkey,
    };

    final dio = Dio();

    try {
      final Uri url =
          Uri.parse(getActivitiesUrl).replace(queryParameters: queryParams);

      final response = await dio.get(
        getActivitiesUrl,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );

      final data = VgetActivitiesResponseModel.fromJson(response.data);

      if (data.statusCode == 200) {
        _activitiesResponseModel = data;
        if (_activitiesResponseModel?.activities != null ||
            _activitiesResponseModel?.activities?.length != 0) {
          setState(() {
            activityDetails = _activitiesResponseModel?.activities;
          });
        }
      } else if (data.statusCode == 400) {
        _activitiesResponseModel = data;
        Alerts.showAlertDialog(context, data.statusMessage,
            Title: "GHMC OFFICER APP", onpressed: () {
          Navigator.pop(context);
        }, buttontext: "Ok");
      } else if (data.statusCode == 600) {
        _activitiesResponseModel = data;
        Alerts.showAlertDialog(context, data.statusMessage,
            Title: "GHMC OFFICER APP", onpressed: () {
          Navigator.pushReplacementNamed(context, AppRoutes.myloginpage);
        }, buttontext: "Ok");
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
              img: Image.asset("assets/cross.png"),
              onPressed: () {
                Navigator.pop(context);
              });
        },
      );
    }
  }

  getCenters(String activityId) async {
    final empid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);

    final headers = {
      'userid': AppConstants.veternaryUserid,
      'hashkey': AppConstants.veternaryHashkey,
    };

    final queryParams = {
      "EmpId": empid,
      "ActivityId": activityId,
    };

    final baseUrl = ApiConstants.VeternaryBaseUrl;
    final getCentersUrl = '${baseUrl + ApiConstants.VeternaryGetCenters}';

    final dio = Dio();

    try {
      final response = await dio.get(
        getCentersUrl,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      final data = getCentersResponseModel.fromJson(response.data);

      if (data.statusCode == 200) {
        setState(() {
          _centersResponseModel = data;
          if (data.centers != null || data.centers?.length != 0) {
            centerDetails = data.centers;
          } else {
            Alerts.showAlertDialog(context, "No data available",
                Title: "GHMC OFFICER APP", onpressed: () {}, buttontext: "ok");
          }
        });
      } else if (data.statusCode == 400) {
        setState(() {
          _centersResponseModel = data;
        });
        Alerts.showAlertDialog(context, _centersResponseModel?.statusMessage,
            Title: "GHMC OFFICER", onpressed: () {
          Navigator.pop(context);
        }, buttontext: "ok");
      } else {
        print(response.statusMessage);
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
              img: Image.asset("assets/cross.png"),
              onPressed: () {
                Navigator.pop(context);
              });
        },
      );
    }
  }

  // get questionnaire
  getQuestionnaire(String activityId) async {
    final headers = {
      'userid': AppConstants.veternaryUserid,
      'hashkey': AppConstants.veternaryHashkey,
    };

    final queryParams = {
      "ActivityId": activityId,
    };

    final baseUrl = ApiConstants.VeternaryBaseUrl;
    final getCentersUrl = '${baseUrl + ApiConstants.VeternaryGetQuestions}';

    final dio = Dio();

    try {
      final response = await dio.get(
        getCentersUrl,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      final data = GetQuestionnaireResponseModel.fromJson(response.data);

      if (data.statusCode == 200) {
        setState(() {
          _getQuestionnaireResponseModel = data;
          questionDetails = data.questions;
        });
      } else if (data.statusCode == 400) {
        setState(() {
          _getQuestionnaireResponseModel = data;
        });
        Alerts.showAlertDialog(
            context, _getQuestionnaireResponseModel?.statusMessage,
            Title: "GHMC OFFICER", onpressed: () {
          Navigator.pop(context);
        }, buttontext: "ok");
      } else {
        print(response.statusMessage);
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
