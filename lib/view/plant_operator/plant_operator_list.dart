import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmcofficerslogin/model/plant_operator/get_plant_operator_response.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/components/searchbar.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/routes/app_routes.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';

class PlantOperatorList extends StatefulWidget {
  const PlantOperatorList({super.key});

  @override
  State<PlantOperatorList> createState() => _PlantOperatorListState();
}

class _PlantOperatorListState extends State<PlantOperatorList> {
  //GetPlantOperatorVehicleTripResponse? _getPlantResponse;
  List<OperatorVehicleList>? operatorVehicleList;
  //List<OperatorVehicleList>? operatorVehicleListResponseList = [];
  // List<OperatorVehicleList> operatorVehicleListSearchListResponse = [];
  List<OperatorVehicleList>? vehicleSearchList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.black),
              onPressed: () async {
                Navigator.pushNamed(context, AppRoutes.plantdashnoard);
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
              "Vehicle Trip At Plant",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            BgImage(imgPath: ImageConstants.bg),
            Column(
              children: [
                ReusableSearchbar(
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
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ListView.builder(
                      itemCount: vehicleSearchList?.length,
                      itemBuilder: (context, index) {
                        final details = vehicleSearchList?[index];

                        return GestureDetector(
                          onTap: () async {
                            AppConstants.vehicleRes = vehicleSearchList?[index];
                            print(vehicleSearchList?[index]);

                            Navigator.pushNamed(
                                context, AppRoutes.vehicletripdtails);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.black87, width: 1),
                              ),
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Column(
                                  children: [
                                    RowComponent(TextConstants.grievanceId,
                                        details?.cNDWGRIEVANCESID),
                                    Line(),
                                    RowComponent(
                                      TextConstants.datetime,
                                      details?.tICKETUPDATEDON,
                                    ),
                                    Line(),
                                    RowComponent(
                                      TextConstants.VehicleNo,
                                      details?.vEHICLENUMBER,
                                    ),
                                    Line(),
                                    RowComponent(
                                      TextConstants.VehicleNo,
                                      details?.vEHICLENUMBER,
                                    ),
                                    Line(),
                                    RowComponent(
                                      TextConstants.typeOfvehicle,
                                      details?.vEHICLETYPE,
                                    ),
                                    Line(),
                                    RowComponent(
                                      TextConstants.driverName,
                                      details?.dRIVERNAME,
                                    ),
                                    Line(),
                                    RowComponent(
                                      TextConstants.mobileNo,
                                      details?.dRIVERMOBILENUMBER,
                                    ),
                                    Line(),
                                    RowComponent(
                                      TextConstants.supervisorName,
                                      details?.sUPERVISORNAME,
                                    ),
                                    Line(),
                                    RowComponent(
                                      TextConstants.inchargeNo,
                                      details?.sUPERVISORNUMBER,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Image.network(
                                        "${details?.bEFORETRIPIMAGE}",
                                        height: 100.0,
                                        width: 100.0,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Text("");
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )),
              ],
            ),
          ],
        ));
  }

  Line() {
    return Divider(
      thickness: 1.0,
      color: Colors.grey,
    );
  }

  RowComponent(var data, var value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              data.toString(),
              style: TextStyle(
                  color: Color.fromARGB(255, 125, 120, 120),
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            flex: 4,
            child: Text(
              value.toString(),
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  _runFilter(String value) {
    List<OperatorVehicleList>? results = [];
    if (value.isEmpty) {
      results = operatorVehicleList;
    } else {
      print("entered value is:  $value");
      results = operatorVehicleList
          ?.where(
              (element) => element.cNDWGRIEVANCESID!.toLowerCase().startsWith(
                    value.toLowerCase(),
                  ))
          .toList();
    }
    setState(() {
      vehicleSearchList = results;
    });
  }

  @override
  void initState() {
    super.initState();

    vehicleSearchList = AppConstants.vehicleList;
    operatorVehicleList = AppConstants.vehicleList;
    print(AppConstants.vehicleList?.length);
    //getdetails();
  }
}
