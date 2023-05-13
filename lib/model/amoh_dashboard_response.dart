class AMOHDashboardListResponse {
  String? sTATUSCODE;
  String? sTATUSMESSAGE;
  List<AMOHList>? aMOHList;

  AMOHDashboardListResponse({this.sTATUSCODE, this.sTATUSMESSAGE, this.aMOHList});

  AMOHDashboardListResponse.fromJson(Map<String, dynamic> json) {
    sTATUSCODE = json['STATUS_CODE'];
    sTATUSMESSAGE = json['STATUS_MESSAGE'];
    if (json['AMOHList'] != null) {
      aMOHList = <AMOHList>[];
      json['AMOHList'].forEach((v) {
        aMOHList!.add(new AMOHList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS_CODE'] = this.sTATUSCODE;
    data['STATUS_MESSAGE'] = this.sTATUSMESSAGE;
    if (this.aMOHList != null) {
      data['AMOHList'] = this.aMOHList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AMOHList {
  String? nOOFREQUESTS;
  String? pAYMENTCONFIRMATION;
  String? cONCESSIONERREJECTED;
  String? cONCESSIONERCLOSETICKETS;
  String? aMOHCLOSETICKETS;

  AMOHList(
      {this.nOOFREQUESTS,
      this.pAYMENTCONFIRMATION,
      this.cONCESSIONERREJECTED,
      this.cONCESSIONERCLOSETICKETS,
      this.aMOHCLOSETICKETS});

  AMOHList.fromJson(Map<String, dynamic> json) {
    nOOFREQUESTS = json['NO_OF_REQUESTS'];
    pAYMENTCONFIRMATION = json['PAYMENT_CONFIRMATION'];
    cONCESSIONERREJECTED = json['CONCESSIONER_REJECTED'];
    cONCESSIONERCLOSETICKETS = json['CONCESSIONER_CLOSE_TICKETS'];
    aMOHCLOSETICKETS = json['AMOH_CLOSE_TICKETS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NO_OF_REQUESTS'] = this.nOOFREQUESTS;
    data['PAYMENT_CONFIRMATION'] = this.pAYMENTCONFIRMATION;
    data['CONCESSIONER_REJECTED'] = this.cONCESSIONERREJECTED;
    data['CONCESSIONER_CLOSE_TICKETS'] = this.cONCESSIONERCLOSETICKETS;
    data['AMOH_CLOSE_TICKETS'] = this.aMOHCLOSETICKETS;
    return data;
  }
}
