import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ghmcofficerslogin/model/get_locations_response.dart';
import 'package:ghmcofficerslogin/model/insert_grievance_response.dart';
import 'package:ghmcofficerslogin/model/new_complaint_response.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/model/where_am_i.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/image_capture.dart';
import 'package:ghmcofficerslogin/res/components/internetcheck.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/showalert_network.dart';
import 'package:ghmcofficerslogin/res/components/showalert_singlebutton.dart';
import 'package:ghmcofficerslogin/res/components/showtoast.dart';
import 'package:ghmcofficerslogin/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/providers/provider_notifiers.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';
import 'package:ghmcofficerslogin/utils/base64.dart';
import 'package:ghmcofficerslogin/utils/device_id.dart';
import 'package:ghmcofficerslogin/view/cutsom_info_window.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NewComplaint extends StatefulWidget {
  const NewComplaint({super.key});

  @override
  State<NewComplaint> createState() => _NewComplaintState();
}

class _NewComplaintState extends State<NewComplaint> {
  InsertGrievanceResponse? insertGrievanceResponse;
  WhereAmIModel? whereAmIModel;
  List<LocationMaster>? locationMaster;

  String? currentAddress;
  Position? _currentPosition;
  final imagePickingOptions = [
    "Choose from Gallery",
    "Take Photo",
    "Choose Document",
    "cancel"
  ];
  bool frommap = false;
  var result;
  var phototype = "";
  var menuId;
  String base64_img1 = "", base64_img2 = "", base64_img3 = "";
  var locate_on_map_lat, locate_on_map_long;
  var current_lat, current_long;

  Map getLocationsData = {};
  Map getSubCategotyData = {};

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
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
    await placemarkFromCoordinates(
            _currentPosition?.latitude ?? 0, _currentPosition?.longitude ?? 0)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  //BestTutorSite _site = BestTutorSite.javatpoint;
  NewComplaintResponse? newComplaintResponse;

  XFile imageData1 = XFile("");
  XFile imageData2 = XFile("");
  XFile imageData3 = XFile("");

  XFile showImageData1 = XFile("");
  XFile showImageData2 = XFile("");
  XFile showImageData3 = XFile("");

  TextEditingController nameController = TextEditingController();
  TextEditingController LandmarkController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController description = TextEditingController();
  String? gender;
  List<NewComplaintResponse>? type = [];
  String? fromlocatevalue;
  var versionNumber;
  var categoryId;
  var subCategoryId;
  var locationLat;
  var locationLong;
  var locateMapId;
  var radius;

  final locationList = ["Use Current Location", "Locate on Map"];
  String? deviceId;
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    String currentDateTime = DateFormat('dd/MM/yyyy hh:mm').format(date);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.black),
            onPressed: () async {
              getLocationsData.clear();
              getSubCategotyData.clear();
              EasyLoading.show();
              Navigator.pushNamed(context, AppRoutes.ghmcdashboard);
            },
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: (() {
              Navigator.of(context).pop();
              newcomplaintdropdown.value = "select";
              selectLocationNameDropdown.value = "Select Location Name";
            })
            //() => Navigator.of(context).pop(),
            ),
        title: Center(
          child: Text(
            "New Complaint",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(
        children: [
          BgImage(imgPath: ImageConstants.bg),
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Text(
                        "Version : ${versionNumber}",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Text(
                        "${currentDateTime}",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                //Location(),
                Theme.of(context).platform == TargetPlatform.iOS
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ValueListenableBuilder(
                          valueListenable: location,
                          builder: (context, value, child) {
                            return RadioGroup<String>.builder(
                              horizontalAlignment: MainAxisAlignment.center,
                              textStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.black,
                              activeColor: Colors.black,
                              direction: Axis.horizontal,
                              groupValue: value ?? "",
                              onChanged: (value) async {
                                location.value = value;
                                if (location.value == "Use Current Location") {
                                  setState(() {
                                    frommap = false;
                                  });
                                  _getCurrentPosition();
                                } else {
                                  setState(() {
                                    frommap = true;
                                  });
                                  result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CustomInfoWindowExample()));
                                }
                              },
                              items: (menuId == "32" || menuId == "33")
                                  ? []
                                  : locationList,
                              itemBuilder: (item) => RadioButtonBuilder(
                                item,
                              ),
                            );
                          },
                        ),
                      ),
                //name
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 3.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        readOnly: true,
                        controller: nameController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Name",
                            hintStyle: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),

                //select Location name
                (menuId == "32" || menuId == "33")
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 2.0),
                        child: ValueListenableBuilder(
                          valueListenable: selectLocationNameDropdown,
                          builder: (context, value, child) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: DropdownButton(
                                  underline:
                                      Container(color: Colors.transparent),
                                  hint: value == null
                                      ? Text('Select Location Name')
                                      : Text(
                                          " " + value,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  dropdownColor: Colors.white,
                                  iconEnabledColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  items: getLocationsData.keys.toList().map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text("  $val"),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      selectLocationNameDropdown.value = val;
                                      categoryId = getLocationsData[val][4];
                                      locationLat = getLocationsData[val][0];
                                      locationLong = getLocationsData[val][1];

                                      locateMapId = getLocationsData[val][3];
                                      radius = getLocationsData[val][2];
                                      newcomplaintdropdown.value = "Select";
                                      getSubCategotyData.values
                                              .contains(categoryId)
                                          ? getSubCategotyData
                                              .forEach((key, value) {
                                              if (value == categoryId) {
                                                setState(() {
                                                  newcomplaintdropdown.value =
                                                      key;
                                                });
                                              }
                                            })
                                          : null;
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 2.0),
                        child: ValueListenableBuilder(
                          valueListenable: newcomplaintdropdown,
                          builder: (context, value, child) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: DropdownButton(
                                    underline:
                                        Container(color: Colors.transparent),
                                    hint: value == null
                                        ? Text('Select')
                                        : Text(
                                            " " + value,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                    isExpanded: true,
                                    iconSize: 30.0,
                                    dropdownColor: Colors.white,
                                    iconEnabledColor: Colors.black,
                                    style: TextStyle(color: Colors.black),
                                    items: getSubCategotyData.keys
                                        .map<DropdownMenuItem<String>>(
                                      (val) {
                                        return DropdownMenuItem<String>(
                                          value: val,
                                          child: Text("  $val"),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        newcomplaintdropdown.value =
                                            val.toString();
                                      });
                                    }),
                              ),
                            );
                          },
                        )),

                //dropdown
                Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 2.0),
                    child: selectLocationNameDropdown.value !=
                            "Select Location Name"
                        ? ValueListenableBuilder(
                            valueListenable: newcomplaintdropdown,
                            builder: (context, value, child) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: DropdownButton(
                                      underline:
                                          Container(color: Colors.transparent),
                                      hint: value == null
                                          ? Text('Select')
                                          : Text(
                                              " " + value,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                      isExpanded: true,
                                      iconSize: 30.0,
                                      dropdownColor: Colors.white,
                                      iconEnabledColor: Colors.black,
                                      style: TextStyle(color: Colors.black),
                                      items: getSubCategotyData.keys
                                          .map<DropdownMenuItem<String>>(
                                        (val) {
                                          return DropdownMenuItem<String>(
                                            value: val,
                                            child: Text("  $val"),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: getSubCategotyData.values
                                              .contains(categoryId)
                                          ? null
                                          : (val) {
                                              setState(() {
                                                newcomplaintdropdown.value =
                                                    val.toString();
                                                subCategoryId =
                                                    getSubCategotyData[val];
                                              });
                                            }),
                                ),
                              );
                            },
                          )
                        : Container()),

                //Landmark
                (menuId == "32" || menuId == "33")
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 2.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextField(
                              textInputAction: TextInputAction.done,
                              //  keyboardType: Text,
                              controller: LandmarkController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Landmark",
                                  hintStyle: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),

                //Enter your Description

                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 2.0),
                    child: Card(
                      color: Colors.white,
                      child: TextField(
                        textInputAction: TextInputAction.done,
                        controller: description,
                        maxLines: null,
                        decoration: new InputDecoration(
                            contentPadding: EdgeInsets.only(left: 8.0),
                            border: InputBorder.none,
                            hintText: "Enter your Description",
                            hintStyle: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),

                //mobile
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 2.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        readOnly: true,
                        controller: mobileController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Contact Number",
                            hintStyle: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),

                //image pickers
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        (menuId == "32" || menuId == "33")
                            ? ImageCapture(
                                callbackValue: (imageData) {
                                  imageData1 = imageData;
                                  base64_img1 =
                                      convertToBase64(imageData1.path);
                                  print("base64_image1 ::: ${base64_img1}");
                                },
                              )
                            : ShowImageCapture(
                                callbackValue: (image1) {
                                  showImageData1 = image1;
                                  base64_img1 =
                                      convertToBase64(showImageData1.path);
                                },
                              ),
                        (menuId == "32" || menuId == "33")
                            ? ImageCapture(
                                callbackValue: (imageData) {
                                  imageData2 = imageData;
                                  base64_img2 =
                                      convertToBase64(imageData2.path);
                                },
                              )
                            : ShowImageCapture(
                                callbackValue: (image1) {
                                  showImageData2 = image1;
                                  base64_img2 =
                                      convertToBase64(showImageData2.path);
                                },
                              ),
                        (menuId == "32" || menuId == "33")
                            ? ImageCapture(
                                callbackValue: (imageData) {
                                  imageData3 = imageData;
                                  base64_img3 =
                                      convertToBase64(imageData3.path);
                                },
                              )
                            : ShowImageCapture(
                                callbackValue: (image1) {
                                  showImageData3 = image1;
                                  base64_img3 =
                                      convertToBase64(showImageData3.path);
                                },
                              ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),

                //submit
                Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.05,
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if (validate()) {
                          if (menuId == "32" || menuId == "33") {
                            if (frommap == true) {
                              locate_on_map_lat = result[0];
                              locate_on_map_long = result[1];
                            } else {
                              current_lat = _currentPosition?.latitude;
                              current_long = _currentPosition?.longitude;
                            }

                            double distance = await Geolocator.distanceBetween(
                              _currentPosition?.latitude ?? 0.0,
                              _currentPosition?.longitude ?? 0.0,
                              double.parse(locationLat),
                              double.parse(locationLong),
                            );
                            print("distance ::: ${distance}");
                            if (radius != null) {
                              if (distance <= double.parse(radius)) {
                                if (frommap == true) {
                                  if (locate_on_map_lat > 0 &&
                                      locate_on_map_long > 0) {
                                    await InternetCheck()
                                        ? whereAmIApiCall(locate_on_map_lat,
                                            locate_on_map_long)
                                        : AlertsNetwork.showAlertDialog(context,
                                            TextConstants.internetcheck,
                                            onpressed: () {
                                            Navigator.pop(context);
                                          }, buttontext: TextConstants.ok);
                                  }
                                } else {
                                  if (current_lat > 0 && current_long > 0) {
                                    await InternetCheck()
                                        ? whereAmIApiCall(
                                            current_lat, current_long)
                                        : AlertsNetwork.showAlertDialog(
                                            context,
                                            TextConstants.internetcheck,
                                            onpressed: () {
                                              Navigator.pop(context);
                                            },
                                            buttontext: TextConstants.ok,
                                          );
                                  }
                                }
                              } else {
                                ShowToats.showToast(
                                    "Your are not within the precise radius",
                                    gravity: ToastGravity.CENTER,
                                    bgcolor: Colors.white,
                                    textcolor: Colors.black);
                              }
                            } else {
                              ShowToats.showToast("Radius is null",
                                  gravity: ToastGravity.CENTER,
                                  bgcolor: Colors.white,
                                  textcolor: Colors.black);
                            }
                          } else {
                            if (frommap == true) {
                              locate_on_map_lat = result[0];
                              locate_on_map_long = result[1];
                            } else {
                              current_lat = _currentPosition?.latitude;
                              current_long = _currentPosition?.longitude;
                            }
                            if (frommap == true) {
                              if (locate_on_map_lat > 0 &&
                                  locate_on_map_long > 0) {
                                await InternetCheck()
                                    ? whereAmIApiCall(
                                        locate_on_map_lat, locate_on_map_long)
                                    : AlertsNetwork.showAlertDialog(
                                        context,
                                        TextConstants.internetcheck,
                                        onpressed: () {
                                          Navigator.pop(context);
                                        },
                                        buttontext: TextConstants.ok,
                                      );
                              }
                            } else {
                              if (current_lat > 0 && current_long > 0) {
                                await InternetCheck()
                                    ? whereAmIApiCall(current_lat, current_long)
                                    : AlertsNetwork.showAlertDialog(
                                        context,
                                        TextConstants.internetcheck,
                                        onpressed: () {
                                          Navigator.pop(context);
                                        },
                                        buttontext: TextConstants.ok,
                                      );
                              }
                            }
                          }
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.transparent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  bool validate() {
    if (menuId == "32" || menuId == "33") {
      if (nameController.text.trim().isEmpty) {
        showToast("Please Select Name");
        return false;
      } else if (selectLocationNameDropdown.value == "Select Location Name") {
        showToast("Please Select Location Name");
        return false;
      } else if (newcomplaintdropdown.value == "Select" ||
          newcomplaintdropdown.value == "select") {
        showToast("Please Select Complaint Status");
        return false;
      } else if (description.text.trim().isEmpty) {
        showToast("Please enter description");
        return false;
      } else if (base64_img1.isEmpty &&
          base64_img2.isEmpty &&
          base64_img3.isEmpty) {
        showToast("Please select an image");
        return false;
      } else if (mobileController.text.isEmpty ||
          mobileController.text.length != 10) {
        showToast("Please enter mobile number");
        return false;
      } else if (!(mobileController.text.startsWith("9") ||
          mobileController.text.startsWith("8") ||
          mobileController.text.startsWith("7") ||
          mobileController.text.startsWith("6"))) {
        showToast("Please enter mobile number");
        return false;
      }
    } else {
      if (nameController.text.trim().isEmpty) {
        showToast("Please Select Name");
        return false;
      } else if (newcomplaintdropdown.value == "Select" ||
          newcomplaintdropdown.value == "select") {
        showToast("Please Select Complaint Status");
        return false;
      } else if (description.text.trim().isEmpty) {
        showToast("Please enter description");
        return false;
      } else if (base64_img1.isEmpty &&
          base64_img2.isEmpty &&
          base64_img3.isEmpty) {
        showToast("Please select an image");
        return false;
      } else if (mobileController.text.isEmpty ||
          mobileController.text.length != 10) {
        showToast("Please select an image");
        return false;
      } else if (!(mobileController.text.startsWith("9") ||
          mobileController.text.startsWith("8") ||
          mobileController.text.startsWith("7") ||
          mobileController.text.startsWith("6"))) {
        showToast("Please enter mobile number");
        return false;
      }
    }
    return true;
  }

  @override
  void initState() {
    super.initState();

    print("version :: ${versionNumber}");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      deviceId = await generateDeviceId();
      getLocationsData.clear();
      getSubCategotyData.clear();
      versionNumber = await SharedPreferencesClass()
          .readTheData(PreferenceConstants.versionNumber);
      await _getCurrentPosition();
      if (await InternetCheck()) {
        await newComplaintDetails();
        await getLocations();
      } else {
        AlertsNetwork.showAlertDialog(context, TextConstants.internetcheck,
            onpressed: () {
          Navigator.pop(context);
        }, buttontext: TextConstants.ok);
      }
    });
  }

  newComplaintDetails() async {
    EasyLoading.show();
    menuId = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.grievance_type);
    var gid = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.grievance_type);
    print("menuid :::: ${menuId}");
    var emp_name =
        await SharedPreferencesClass().readTheData(PreferenceConstants.name);
    var mobile_no = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.mobileno);
    print("mobile ${mobile_no}");
    //creating request url with base url and endpoint
    //
    setState(() {
      nameController.text = "${emp_name}";
      mobileController.text = "${mobile_no}";
    });
    const requesturl =
        ApiConstants.baseurl + ApiConstants.new_complaint_endpoint;

    print("new complaint request url ::: ${requesturl}");

    var requestPayload = {
      "Latitude": "${_currentPosition?.latitude}",
      "Longitude": "${_currentPosition?.longitude}",
      "gid": gid,
      "password": AppConstants.password,
      "userid": AppConstants.userid
    };

    print("new complaint :::: ${requestPayload}");

    //no headers and authorization

    //creating dio object in order to connect package to server
    final dioObject = Dio();

    try {
      final response = await dioObject.post(
        requesturl,
        data: requestPayload,
      );
      var len = response.data.length;

      print("new complaint response :::: ${response}");

      //converting response from String to json
      for (var i = 0; i < len; i++) {
        final data = NewComplaintResponse.fromJson(response.data[i]);
        EasyLoading.dismiss();
        setState(() {
          if (data.status == "success") {
            getSubCategotyData.clear();
            newComplaintResponse = data;
            type?.add(newComplaintResponse!);
            type?.forEach((element) {
              getSubCategotyData[element.type] = element.id;
            });
          }
        });
      }

      print("location data ${getSubCategotyData}");
    } on DioError catch (e) {
      EasyLoading.dismiss();
        showDialog(
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

  insertGrievance(double? latitude, double? longitude) async {
    var mobileno = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.mobileno);
    var gid = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.grievance_type);
    var empname =
        await SharedPreferencesClass().readTheData(PreferenceConstants.name);

    const requesturl = ApiConstants.baseurl +
        ApiConstants.new_compliant_insert_grievance_submit;

    print("request url :::: ${requesturl}");

    final requestPayload = {
      "userid": AppConstants.userid,
      "password": AppConstants.password,
      "remarks": description.text,
      "photo": base64_img1,
      "photo2": base64_img2,
      "photo3": base64_img3,
      "latlon": "${latitude},${longitude}", //"17.436617,78.3608504",
      "mobileno": "${mobileno}-${mobileController.text}",
      "deviceid": deviceId,
      "compType": gid,
      "landmark": LandmarkController.text,
      "username": empname,
      "ward": "0",
      "source": "20",
      "empid": "",
      "agentid": "",
      "Location_Id": "${locateMapId ?? ''}"
    };

    print("insert grievance payload :::: ${requestPayload} ");

    final dioObject = Dio();

    try {
      final response = await dioObject.post(
        requesturl,
        data: requestPayload,
      );
      print("insert grievance response ${response.data}");
      //converting response from String to json

      final data = InsertGrievanceResponse.fromJson(response.data);
      EasyLoading.dismiss();
      insertGrievanceResponse = data;
      setState(() {
        if (data.status == "True") {
          AlertWithOk.showAlertDialog(
              context, "${insertGrievanceResponse?.compid}", onpressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.ghmcdashboard);
          }, buttontext: "OK", buttontextcolor: Colors.teal);
        } else {
          AlertWithOk.showAlertDialog(
              context, "${insertGrievanceResponse?.compid}", onpressed: () {
            Navigator.pop(context);
          }, buttontext: "OK", buttontextcolor: Colors.teal);
        }
        //type.add(newComplaintResponse?.type);
      });
      //  print(type);
    } on DioError catch (e) {
      EasyLoading.dismiss();
      showDialog(
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
      print("error is $e");

      //print("status code is ${e.response?.statusCode}");
    }
  }

  whereAmIApiCall(double? latitude, double? longitude) async {
    EasyLoading.show();
    final whereAmiUrl = ApiConstants.baseurl + ApiConstants.where_am_i;
    // "https://19cghmc.cgg.gov.in/myghmcwebapi/Grievance/WhereAmI";
    final whereami_payload = {
      "userid": AppConstants.userid,
      "password": AppConstants.password,
      "latitude": latitude,
      "longitude": longitude
    };
    print("where am i payload :::: ${whereami_payload}");
    final dio_obj = Dio();
    try {
      final whereami_response =
          await dio_obj.post(whereAmiUrl, data: whereami_payload);
      print("where am i response ${whereami_response.data}");
      final data = WhereAmIModel.fromJson(whereami_response.data);
      setState(() {
        if (data.status == true) {
          insertGrievance(latitude, longitude);
        } else {
          EasyLoading.dismiss();
          AlertWithOk.showAlertDialog(context, TextConstants.selected_location,
              onpressed: () {
            Navigator.pop(context);
          }, buttontext: TextConstants.ok);
        }
      });
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
                Navigator.pop(context);
                });
          },
        );
      }
    }

  Future<void> getLocations() async {
    EasyLoading.show();
    var mobileno = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.mobileno);
    var gid = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.grievance_type);

    const requesturl = ApiConstants.baseurl + ApiConstants.getLocations;

    var requestPayload = {
      "userid": AppConstants.userid,
      "password": AppConstants.password,
      "Mobileno": "${mobileno}", //9908689335
      "Gid": "${gid}"
    };
    final dioObject = Dio();
    try {
      final response = await dioObject.post(
        requesturl,
        data: requestPayload,
      );

      //converting response from String to json
      final data = getLocationsResponse.fromJson(response.data);
      EasyLoading.dismiss();
      setState(() {
        if (data.statusCode == "200") {
          locationMaster = data.locationMaster;
          locationMaster?.forEach((element) {
            getLocationsData["Select Location Name"] = [""];
            getLocationsData[element.lOCATIONNAME] = [
              element.lATITUDES,
              element.lONGITUDES,
              element.rADIUS,
              element.lOCATIONMAPID,
              element.cATEGORYID
            ];
          });
          print("location data ${getLocationsData}");
        }
      });
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
                Navigator.pop(context);
              });
        },
      );
    }
  }
}
