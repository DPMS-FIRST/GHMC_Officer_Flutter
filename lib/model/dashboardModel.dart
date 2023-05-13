class GhmcDashboardResponse {
  String? status;
  String? statusMessage;
  List<DashboardMenu>? dashboardMenu;
  List<GrievanceDashboard>? grievanceDashboard;

  GhmcDashboardResponse(
      {this.status,
      this.statusMessage,
      this.dashboardMenu,
      this.grievanceDashboard});

  GhmcDashboardResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_Message'];
    if (json['Dashboard_Menu'] != null) {
      dashboardMenu = <DashboardMenu>[];
      json['Dashboard_Menu'].forEach((v) {
        dashboardMenu!.add(new DashboardMenu.fromJson(v));
      });
    }
    if (json['Grievance_Dashboard'] != null) {
      grievanceDashboard = <GrievanceDashboard>[];
      json['Grievance_Dashboard'].forEach((v) {
        grievanceDashboard!.add(new GrievanceDashboard.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_Message'] = this.statusMessage;
    if (this.dashboardMenu != null) {
      data['Dashboard_Menu'] =
          this.dashboardMenu!.map((v) => v.toJson()).toList();
    }
    if (this.grievanceDashboard != null) {
      data['Grievance_Dashboard'] =
          this.grievanceDashboard!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DashboardMenu {
  String? iMENUID;
  String? mENUNAME;
  String? uRL;

  DashboardMenu({this.iMENUID, this.mENUNAME, this.uRL});

  DashboardMenu.fromJson(Map<String, dynamic> json) {
    iMENUID = json['I_MENUID'];
    mENUNAME = json['MENUNAME'];
    uRL = json['URL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['I_MENUID'] = this.iMENUID;
    data['MENUNAME'] = this.mENUNAME;
    data['URL'] = this.uRL;
    return data;
  }
}

class GrievanceDashboard {
  String? total;
  String? sLF;
  String? nONSLF;
  String? iD;
  String? mENUNAME;
  String? count;

  GrievanceDashboard(
      {this.total, this.sLF, this.nONSLF, this.iD, this.mENUNAME, this.count});

  GrievanceDashboard.fromJson(Map<String, dynamic> json) {
    total = json['Total'];
    sLF = json['SLF'];
    nONSLF = json['NON_SLF'];
    iD = json['ID'];
    mENUNAME = json['MENUNAME'];
    count = json['Count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Total'] = this.total;
    data['SLF'] = this.sLF;
    data['NON_SLF'] = this.nONSLF;
    data['ID'] = this.iD;
    data['MENUNAME'] = this.mENUNAME;
    data['Count'] = this.count;
    return data;
  }
}
