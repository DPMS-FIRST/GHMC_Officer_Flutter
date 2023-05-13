import 'package:flutter/material.dart';
import 'package:ghmcofficerslogin/view/SplashScreen.dart';
import 'package:ghmcofficerslogin/view/GhmcDashboard.dart';
import 'package:ghmcofficerslogin/view/abstract_report.dart';
import 'package:ghmcofficerslogin/view/amoh_concessioner_closed_ticket_details.dart';
import 'package:ghmcofficerslogin/view/amount_paid.dart';
import 'package:ghmcofficerslogin/view/check_status_new.dart';
import 'package:ghmcofficerslogin/view/concessionaire/c_incharge_ticket_details.dart';
import 'package:ghmcofficerslogin/view/corporator_login/corporator_view_doc.dart';
import 'package:ghmcofficerslogin/view/display_user_details.dart';
import 'package:ghmcofficerslogin/view/fulldetails.dart';
import 'package:ghmcofficerslogin/view/grievance_details.dart';
import 'package:ghmcofficerslogin/view/grievance_history.dart';
import 'package:ghmcofficerslogin/view/grievance_type.dart';
import 'package:ghmcofficerslogin/view/image_view.dart';
import 'package:ghmcofficerslogin/view/inbox.dart';
import 'package:ghmcofficerslogin/view/loginpage.dart';
import 'package:ghmcofficerslogin/view/new_complaint.dart';
import 'package:ghmcofficerslogin/view/otp_view.dart';
import 'package:ghmcofficerslogin/view/plant_operator/plant_operator_dashboard.dart';
import 'package:ghmcofficerslogin/view/plant_operator/plant_operator_list.dart';
import 'package:ghmcofficerslogin/view/plant_operator/vehicle_trip_details.dart';
import 'package:ghmcofficerslogin/view/post_comment.dart';
import 'package:ghmcofficerslogin/view/privacy_policy.dart';
import 'package:ghmcofficerslogin/view/set_mpin_view.dart';
import 'package:ghmcofficerslogin/view/take_action_new.dart';
import 'package:ghmcofficerslogin/view/total_grievances.dart';
import 'package:ghmcofficerslogin/view/veternaryform.dart';
import 'package:ghmcofficerslogin/view/view_comments.dart';
import 'package:ghmcofficerslogin/view/Concessionaire/c_closed_list.dart';
import 'package:ghmcofficerslogin/view/Concessionaire/c_dashboard.dart';
import 'package:ghmcofficerslogin/view/amoh_close_ticket_details.dart';
import 'package:ghmcofficerslogin/view/amoh_dashboard.dart';
import 'package:ghmcofficerslogin/view/concessionaire/c_incharge_manual_closing_tickets.dart';
import 'package:ghmcofficerslogin/view/concessionaire/c_incharge_ticketlist.dart';
import 'package:ghmcofficerslogin/view/concessionaire/c_rejection_ticketlist.dart';
import 'package:ghmcofficerslogin/view/consessioner_closed_tickets_list.dart';
import 'package:ghmcofficerslogin/view/corporator_login/corporator_dashboard.dart';
import 'package:ghmcofficerslogin/view/payment_raise_request.dart';
import 'package:ghmcofficerslogin/view/amoh_closed_ticket_list.dart';
import 'package:ghmcofficerslogin/view/raise_request.dart';
import 'package:ghmcofficerslogin/view/reject_or_reassign.dart';
import 'package:ghmcofficerslogin/view/rejected_tickets.dart';
import 'package:ghmcofficerslogin/view/request_by_amoh.dart';
import 'package:ghmcofficerslogin/view/request_estimation.dart';
import 'package:ghmcofficerslogin/view/request_list.dart';
import 'package:ghmcofficerslogin/view/validate_mpin.dart';
import '../../../view/concessionaire/c_incharge_manual_closing_ticketes_list.dart';
import '../../../view/concessionaire/c_pickup_capture.dart';
import '../../../view/concessionaire/c_pickup_capturelist.dart';
import 'app_routes.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.mysplashscreen: ((context) => const MySplashScreen()),
      AppRoutes.myloginpage: ((context) => const Loginpage()),
      AppRoutes.ghmcdashboard: ((context) => const GhmcDashboard()),
      //AppRoutes.navigation:((context) => const Navigation()),
      AppRoutes.mytotalgrievances: ((context) => const MyTotalGrievances()),
      AppRoutes.privacypolicy: ((context) => const privacyPolicy()),
      AppRoutes.userdetails: ((context) => const UserDetails()),
      AppRoutes.fullgrievancedetails: ((context) =>
          const FullGrievanceDetails()),
      AppRoutes.grievancehistory: ((context) => const GrievanceHistory()),
      AppRoutes.otpView: ((context) => const OTPView()),
      AppRoutes.set_mpin_view: ((context) => SetMpinView()),
      AppRoutes.viewcomment: ((context) => ViewCommentsScreen()),
      AppRoutes.imageviewpage: ((context) => ImageViewPage(
            filePath: '',
            filename: '',
          )),
      AppRoutes.raisegrievance: ((context) => const RaiseGrievance()),
      AppRoutes.newcomplaint: ((context) => const NewComplaint()),
      AppRoutes.newmpin: ((context) => const Mpin()),
      AppRoutes.abstractreport: ((context) => AbstractReport()),
      AppRoutes.inboxnotification: ((context) => InboxNotifications()),
      AppRoutes.grivancedetails: ((Context) => GrievanceDetails()),
      AppRoutes.postcomment: ((context) => PostComment()),
      AppRoutes.consructiondemolitionwaste: ((context) => AmohDashboardList()),
      AppRoutes.requestlist: ((context) => RequestList()),
      AppRoutes.requestbyamoh: ((context) => RequestByAmohList()),
      AppRoutes.amohamountpayedlist: ((context) => AmohAmountPayedList()),
      AppRoutes.rejectedtickets: ((context) =>
          ConsessionerRejectedTicketsList()),
      AppRoutes.closedticketlist: ((context) => ConsessionerClosedTicketList()),
      AppRoutes.amohclosedticketlist: ((context) => AmohClosedTicketList()),
      AppRoutes.requestestimation: ((context) => RequestEstimation()),
      AppRoutes.raiserequest: ((context) => RaiseRequest()),
      AppRoutes.rejectorresassign: ((context) => RejectOrReassign()),
      AppRoutes.closeticketdetails: ((context) => AmohCloseTicketDetails()),

      AppRoutes.raiserequest_raiserequest: ((context) =>
          RaiseRequest_RaiseRequest()),
      //operator
      AppRoutes.plantdashnoard: ((context) => PlantOperatorDashboardScreen()),
      AppRoutes.plantoperatorlist: ((context) => PlantOperatorList()),
      AppRoutes.vehicletripdtails: ((context) => VehicleTripDetails()),
      //concessioner

      AppRoutes.concessionairedashboard: ((context) =>
          ConcessionaireDashboard()),
      AppRoutes.concessionairinchargepickupcapturelist: ((context) =>
          ConcessionerPickupCaptureList()),
      AppRoutes.concessionairepickupcapture: ((context) =>
          ConcessionairePickupCapture()),

      AppRoutes.crejectionticketlist: ((context) => CRejectionTicketlist()),
      AppRoutes.cclosedlist: ((context) => CClosedList()),
      AppRoutes.cinchargeticketlist: ((context) => CInchargeTicketList()),

      AppRoutes.concessionaireinchargemanualclosingtickets: ((context) =>
          ConcessionaireInchargeManualClosingTickets()),
      AppRoutes.concessionaireinchargemanualclosingticketslist: ((context) =>
          ConcessionaireInchargeManualClosingTicketsList()),
      AppRoutes.cinchargeticketdetails: ((context) => CInchargeTicketDetails()),
      //corporator
      AppRoutes.corporatordashboard: ((context) => CorporatorDashboard()),
      AppRoutes.corporatorviewdoc: ((context) => CorporatorViewDoc()),
      AppRoutes.amohclosedticketdetails: ((context) =>
          AmohCCloseTicketDetails()),
      AppRoutes.checkstatusnew: ((context) => Check()),
      AppRoutes.takeactionnew: (context) => TakeActionNew(),
      AppRoutes.veternaryform: (context) => VeternaryForm(),
    };
  }
}
