import 'package:ghmcofficerslogin/data/amount_paid_response.dart';

import 'package:ghmcofficerslogin/model/concessioner/c_incharge_ticketlist_res.dart'
    as cinchargetickelist;
import 'package:ghmcofficerslogin/model/concessioner/concessionaire_incharge_manual_closing_tickets_res.dart'
    as manualticketlist;
import 'package:ghmcofficerslogin/model/plant_operator/get_plant_operator_response.dart';
import 'package:ghmcofficerslogin/model/get_vehicles_reponse.dart'
    as requestestimationvehiclestypelist;
import 'package:ghmcofficerslogin/model/amount_paid_response.dart'
    as amohamountpaid;
import 'package:ghmcofficerslogin/model/request_estimation_response.dart'
    as requestestimationvehiclelist;
import '../../model/c_closed_tickets_response.dart'
    as concessionerclosedticketslist;
import 'package:ghmcofficerslogin/model/amoh_closed_ticket_list_response.dart'
    as amohcloseticketdetails;

import '../../model/concessioner/concessionaire_pickup_capturelist_res.dart'
    as pickupcapturelist;

class AppConstants {
  static String frommap = "";

  AppConstants._();
  static String mysplashscreen = "/mysplashscreen";
  static String userid = "cgg@ghmc";
  static String password = "ghmc@cgg@2018";
  static String veternaryUserid = "G#MCSTRAYDOG";
  static String veternaryHashkey = "RyNNQ1NUUkFZRE9HVEVTVA==";
  //static List<Comments>? commentsItemsList = null;
//static List<Comments>? concessionaireInchargeManualClosingTicketlist = null;
  static OperatorVehicleList? vehicleRes = null;

  static List<OperatorVehicleList>? vehicleList = null;
  // static List<PLANTDTLS>? plantnames = null;
  static final imagePickingOptions = [
    "Take Photo",
    "Choose from Library",
    "cancel"
  ];
  //static ClosingTicketList ?closingTicketList = null;

  static manualticketlist.TicketList?
      concessionaireInchargeManualClosingTicketlist = null;
  static pickupcapturelist.TicketList? ticktetitemslist = null;
  // static ClosedAmohTicketList ?   amoh_close_ticket_details = null;
  static VehicleDetailsList? amoh_vehicle_details_list = null;

  static String amount_paid_ticket_id = "";
  static String amount_paid_image = "";
  static String amount_paid_estwasteintons = "";
  //static amountpaidvehicledetailslist.VehicleDetailsList? vehicle_details_list= null;
  static String amount_paid_wardid = "";
  //
  static String request_list_ticket_id = "";
  static String request_list_image = "";

  //reject / Reassign
  static String consessioner_rejected_ticket_id = "";
  static String consessioner_rejected_image = "";
  static String consessioner_rejected_reasons_for_rejection = "";

  //
  static cinchargetickelist.ChargeTicketList? c_incharge_ticket_list = null;
  static cinchargetickelist.CInchargeVehicleList?
      c_incharge_ticket_list_vehicle_list = null;

  //amoh concessioner closed ticket details
  static concessionerclosedticketslist.TicketList? amoh_closedticketlist = null;

  static amohamountpaid.VehicleDetailsList? vehicle_details_list = null;
//request estimation
  static requestestimationvehiclelist.VehicleList?
      request_estimation_vehiclelist = null;
  static requestestimationvehiclestypelist.VEHICLELIST? vehicletypeslist = null;

  //amoh closed ticket details
  static amohcloseticketdetails.TicketList? amoh_close_ticket_details = null;
  static amohamountpaid.PaidList? amohamountpaidlist = null;

  static double? custominfowindowlat;
  static double? custominfowindowlong;
}
