class ConcessionerDashboardListRes {
  String? sTATUSCODE;
  String? sTATUSMESSAGE;
  List<AMOHList>? aMOHList;

  ConcessionerDashboardListRes(
      {this.sTATUSCODE, this.sTATUSMESSAGE, this.aMOHList});

  ConcessionerDashboardListRes.fromJson(Map<String, dynamic> json) {
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
  String? cONCESSIONERTICKETSCOUNT;
  String? cONCESSIONERPICKUPCAPTURECOUNT;
  String? cONCESSIONERREJECTEDCOUNT;
  String? cONCESSIONERCLOSEDCOUNT;
  String? cONCESSIONERCLOSINGTICKETCOUNT;

  AMOHList(
      {this.cONCESSIONERTICKETSCOUNT,
      this.cONCESSIONERPICKUPCAPTURECOUNT,
      this.cONCESSIONERREJECTEDCOUNT,
      this.cONCESSIONERCLOSEDCOUNT,
      this.cONCESSIONERCLOSINGTICKETCOUNT});

  AMOHList.fromJson(Map<String, dynamic> json) {
    cONCESSIONERTICKETSCOUNT = json['CONCESSIONER_TICKETS_COUNT'];
    cONCESSIONERPICKUPCAPTURECOUNT = json['CONCESSIONER_PICKUP_CAPTURE_COUNT'];
    cONCESSIONERREJECTEDCOUNT = json['CONCESSIONER_REJECTED_COUNT'];
    cONCESSIONERCLOSEDCOUNT = json['CONCESSIONER_CLOSED_COUNT'];
    cONCESSIONERCLOSINGTICKETCOUNT = json['CONCESSIONER_CLOSING_TICKET_COUNT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CONCESSIONER_TICKETS_COUNT'] = this.cONCESSIONERTICKETSCOUNT;
    data['CONCESSIONER_PICKUP_CAPTURE_COUNT'] =
        this.cONCESSIONERPICKUPCAPTURECOUNT;
    data['CONCESSIONER_REJECTED_COUNT'] = this.cONCESSIONERREJECTEDCOUNT;
    data['CONCESSIONER_CLOSED_COUNT'] = this.cONCESSIONERCLOSEDCOUNT;
    data['CONCESSIONER_CLOSING_TICKET_COUNT'] =
        this.cONCESSIONERCLOSINGTICKETCOUNT;
    return data;
  }
}
