import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ghmcofficerslogin/res/components/background_image.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:ghmcofficerslogin/res/constants/app_constants.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CInchargeTicketDetails extends StatefulWidget {
  const CInchargeTicketDetails({super.key});

  @override
  State<CInchargeTicketDetails> createState() => _CInchargeTicketDetailsState();
}

class _CInchargeTicketDetailsState extends State<CInchargeTicketDetails> {
  String? reason;
  StreamSubscription? connection;
  bool isoffline = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: (() {
              Navigator.of(context).pop();
            })),
        title: Center(
          child: Text(
            "Concessionaire Ticket Details",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ),
      body: Stack(children: [
        BgImage(imgPath: ImageConstants.bg),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                RowComponent(
                    TextConstants.c_inchrge_ticket_details_currentdate,
                    DateFormat("dd/MM/yyyy hh:mm a").format(DateTime.now()),
                    Colors.white),
                RowComponent(
                    TextConstants.c_inchrge_ticket_details_zone,
                    AppConstants.c_incharge_ticket_list?.zONENAME,
                    Colors.white),
                RowComponent(
                    TextConstants.c_inchrge_ticket_details_circle,
                    AppConstants.c_incharge_ticket_list?.cIRCLENAME ?? "",
                    Colors.white),
                RowComponent(
                    TextConstants.c_inchrge_ticket_details_ward,
                    AppConstants.c_incharge_ticket_list?.wARDNAME ?? "",
                    Colors.white),
                RowComponent(
                    TextConstants.c_inchrge_ticket_details_location,
                    AppConstants.c_incharge_ticket_list?.lOCATION ?? "",
                    Colors.white),
                RowComponent(
                    TextConstants.c_inchrge_ticket_details_citizen_raised_date,
                    AppConstants.c_incharge_ticket_list?.lANDMARK ?? "",
                    Colors.white),
                RowComponent(
                    TextConstants.c_inchrge_ticket_details_amoh_forward_date,
                    AppConstants.c_incharge_ticket_list?.aMOHFORWARDEDDATE ??
                        "",
                    Colors.white),
                RowComponent(
                    TextConstants.c_inchrge_ticket_details_type_of_waste,
                    AppConstants.c_incharge_ticket_list?.tYPEOFWASTE ?? "",
                    Colors.white),
                RowComponent(TextConstants.c_inchrge_ticket_details_image, "",
                    Colors.white),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image.network(
                    "${AppConstants.c_incharge_ticket_list?.iMAGE1PATH}",
                    height: 100.0,
                    width: 100.0,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        ImageConstants.no_uploaded,
                        height: 100.0,
                        width: 100.0,
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, right: 10.0, left: 8.0),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              TextConstants
                                  .c_inchrge_ticket_details_vehicletype,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                            flex: 2,
                            child: Text(
                                TextConstants
                                    .c_inchrge_ticket_details_no_of_trips,
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(
                            flex: 1,
                            child: Text(
                                TextConstants.c_inchrge_ticket_details_amount,
                                style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 4.0, right: 10.0, left: 8.0),
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                                "${AppConstants.c_incharge_ticket_list_vehicle_list?.vEHICLETYPE}")),
                        Expanded(
                            flex: 2,
                            child: Center(
                                child: Text(
                                    "${AppConstants.c_incharge_ticket_list_vehicle_list?.nOOFVEHICLES}"))),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                                    "${AppConstants.c_incharge_ticket_list_vehicle_list?.aMOUNT}"))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                TextConstants
                                    .c_inchrge_ticket_details_do_you_want,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RadioListTile(
                              title: Text(
                                  TextConstants.c_inchrge_ticket_details_accept,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10)),
                              value:
                                  TextConstants.c_inchrge_ticket_details_accept,
                              groupValue: reason,
                              onChanged: (value) {
                                setState(() {
                                  reason = value.toString();
                                });
                              },
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RadioListTile(
                              title: Text(
                                  TextConstants.c_inchrge_ticket_details_reject,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10)),
                              value:
                                  TextConstants.c_inchrge_ticket_details_reject,
                              groupValue: reason,
                              onChanged: (value) {
                                setState(() {
                                  reason = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.05,
                          margin: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              double lattitude = double.parse(
                                  "${AppConstants.c_incharge_ticket_list?.lATITUDE}");
                              double longitude = double.parse(
                                  "${AppConstants.c_incharge_ticket_list?.lONGITUDE}");

                              navigateTo(lattitude, longitude);

                              // showAlert(raiseRequestSubmitResponse?.sTATUSMESSAGE);
                            },
                            child: Text(
                              "${TextConstants.view_directions}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.05,
                          margin: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                          ),
                          child: TextButton(
                            onPressed: () async {},
                            child: Text(
                              "${TextConstants.concessionaire_pickup_capture_submit}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
  static void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }
  /*  void _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } */

  RowComponent(var data, var value, var color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              data.toString(),
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 4,
            child: Text(
              value.toString(),
              style: TextStyle(color: color, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
