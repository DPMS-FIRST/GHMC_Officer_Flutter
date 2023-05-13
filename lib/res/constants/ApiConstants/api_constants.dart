class ApiConstants {
  static const String baseurl =
      "https://19cghmc.cgg.gov.in/myghmcwebapi/Grievance/";

  static const String uatBaseUrl =
      "https://uatghmc.cgg.gov.in/MyGhmcServices/Grievance/";

  static const String endpoint = "GetTotalCount_And_Menus";

  static const String splash_endpoint = "versionCheckOfficer";

  static const String login_endpoint = "getMpin";

  static const String userlist_endpoint = "UserList";

  static const String userdetails_endpoint = "validategrievance";

  static const String fulldetails_endpoint = "viewTypeGrievances";

  static const String history_endpoint = "viewGrievanceHistory1";

  static const String search_endpoint = "viewGrievanceHistory1";

  static const String raise_grievance_endpoint = "CategoryList";

  static const String resend_otp_endpoint = "ResendOTP";

  static const String update_mpin = "updateMpin";

  static const String new_complaint_endpoint = "getSubCategoty";

  static const String get_ward_endpoint = "getWard";

  static const String get_lower_staff_endpoint = "getLowerStaff";

  static const String update_grievance_end_point = "updateGrievance";

  static const String check_status_endpoint = "viewGrievances";

  static const String grievance_details_endpoint = "getGrievanceStatusCitizen";

  static const String postcomment_endpoint = "updateGrievance";

  static const String abstract_report_endpoint = "empAbstractProfile";

  static const String inbox_notifications_endpoint = "ShowNotifications";

  static const String takeaction_endpoint = "getStatusType";

  static const String takeaction_getlowerstaff_endpoint = "getLowerStaff";

  static const String where_am_i = "WhereAmI";

  static const String getLocations = "GetLocations";

  //concessioner
  static const String concessionaire_baseurl =
      "https://qaghmc.cgg.gov.in/CNDMAPI/CNDM/"; //https://qaghmc.cgg.gov.in/CNDMAPI/CNDM/

  static const String concessionaire_dashboard_endpoint =
      "GET_CONCESSIONER_DASHBOARD_LIST";

  static const String concessionaire_incharge_pickup_capturelist_endpoint =
      "GET_CONCESSIONER_PICKUP_CAPTURE_LIST";

  static const String
      concessionaire_incharge_pickup_capture_bind_plant_name_endpoint =
      "BIND_PLANT_NAME";

  static const String concessionaire_incharge_pickup_capture_vehicletypes =
      "GetVehicleTypes";

  static const String concessionaire_incharge_manual_closing_tickets_endpoint =
      "CONCESSIONER_MANUAL_CLOSING_TICKET_LIST";

  static const String crejection_ticketlist_endpoint =
      "CONCESSIONER_REJECTED_TICKETS_LIST";

  static const String c_incharge_ticketlist_endpoint =
      "GET_CONCESSIONER_TICKET_LIST";

  static const String cclosed_list_endpoint =
      "GET_CONCESSIONER_CLOSED_TICKETS_LIST";

  // static const String where_am_i = "WhereAmI";

  static const String cndw_baseurl = "https://qaghmc.cgg.gov.in/CNDMAPI/CNDM/";

  static const String amoh_dash_list_endpoint = "GET_AMOH_DASHBOARD_LIST";

  static const String amoh_raised_list_endpoint = "GET_AMOH_RAISED_LIST";

  static const String amoh_request_list_endpoint = "GET_AMOH_REQUEST_LIST";

  static const String amoh_paid_list_endpoint = "GET_AMOH_AMOUNT_PAID_LIST";

  // corporator
  static const String corporatorList = "CorporatorList";

  static const String corporatorReport = "GarbageDumpPDF";

  ///amoh
  static const String amoh_closed_ticket_list_endpoint =
      "AMOH_CLOSED_TICKETS_LIST";
  static const String amoh_close_amoh_closed_ticket_submit =
      "AMOH_CLOSE_AMOH_CLOSE_TICKET_SUBMIT";
  static const String consessioner_closed_tickets_list_endpoint =
      "AMOH_GET_CONCESSIONER_CLOSED_TICKETS_LIST";
  static const String request_estimation_endpoint =
      "GET_AMOH_REQUEST_ESTIMATION_BY_ID";
  static const String amoh_raise_request_submit = "AMOH_RAISE_REQUEST_SUBMIT";
  static const String amoh_request_by_endpoint = "GET_AMOH_RAISED_LIST";
  static const String request_estimation_submit_endpoint =
      "AMOH_REQUEST_ESTIMATION_SUBMIT";
  static const String get_vehicle_type = "GetVehicleTypes";
  static const String consessioner_rejected_ticket_list_endpoint =
      "CONCESSIONER_REJECTED_TICKETS_LIST";
  static const String amoh_reassign_concessioner_rejected_tickets =
      "AMOH_REASSIGN_CONCESSIONER_REJECTED_TICKETS";
  static const String mobile_menu_list = "MobileMenuList";

  static const String new_compliant_insert_grievance_submit = "insertGrievance";
  static const String amoh_raise_request_forwar_to_next_ward =
      "FORWARDTO_NEXTWARD";

  static const String amoh_raise_raise_request_submit =
      "AMOH_RAISE_GRIEVANCE_SUBMIT";

  static const String amoh_closed_ticket_submit_endpoint =
      "AMOH_CLOSE_AMOH_CLOSE_TICKET_SUBMIT";

  static const String amoh_concessioner_closed_ticket_submit_endpoint =
      "AMOH_CLOSE_CONCESSIONER_CLOSE_TICKET_SUBMIT";
  static const String amoh_raise_request_demographics_endpoint =
      "GET_DEMOGRAPHICS";

  static const String concessionaire_incharge_pickup_capture_details_submit =
      "CONCESSIONER_PICKUP_CAPTURE_SUBMIT";

  static const String c_incharge_manual_closing_tickets_submit =
      "CONCESSIONER_MANUAL_CLOSING_TICKET_SUBMIT";

  static const String amoh_c_close_ticket_submit =
      "AMOH_CLOSE_CONCESSIONER_CLOSE_TICKET_SUBMIT";

  static const String VeternaryBaseUrl =
      "https://devghmc.cgg.gov.in/myghmcwebapi/StrayDog/";
  static const String VeternaryGetActivities = "GetActivities";
  static const String VeternaryGetCenters = "GetCenters";
  static const String VeternaryGetQuestions = "GetQuestionnaire";
}
