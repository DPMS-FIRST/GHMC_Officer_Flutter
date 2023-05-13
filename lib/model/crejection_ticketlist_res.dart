class CRejectedTicketListRes {
  String? sTATUSCODE;
  String? sTATUSMESSAGE;
  List<TicketList>? ticketList;

  CRejectedTicketListRes(
      {this.sTATUSCODE, this.sTATUSMESSAGE, this.ticketList});

  CRejectedTicketListRes.fromJson(Map<String, dynamic> json) {
    sTATUSCODE = json['STATUS_CODE'];
    sTATUSMESSAGE = json['STATUS_MESSAGE'];
    if (json['TicketList'] != null) {
      ticketList = <TicketList>[];
      json['TicketList'].forEach((v) {
        ticketList!.add(new TicketList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS_CODE'] = this.sTATUSCODE;
    data['STATUS_MESSAGE'] = this.sTATUSMESSAGE;
    if (this.ticketList != null) {
      data['TicketList'] = this.ticketList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketList {
  String? tICKETID;
  String? lOCATION;
  String? cREATEDDATE;
  String? rEASONFORREJECT;
  String? pAYMENTSTATUS;
  String? wARDID;
  String? wARDNAME;
  String? cIRCLEID;
  String? cIRCLENAME;
  String? zONEID;
  String? zONENAME;
  String? lANDMARK;
  String? iMAGE1PATH;
  String? sTATUS;
  String? tYPEOFWASTE;

  TicketList(
      {this.tICKETID,
      this.lOCATION,
      this.cREATEDDATE,
      this.rEASONFORREJECT,
      this.pAYMENTSTATUS,
      this.wARDID,
      this.wARDNAME,
      this.cIRCLEID,
      this.cIRCLENAME,
      this.zONEID,
      this.zONENAME,
      this.lANDMARK,
      this.iMAGE1PATH,
      this.sTATUS,
      this.tYPEOFWASTE});

  TicketList.fromJson(Map<String, dynamic> json) {
    tICKETID = json['TICKET_ID'];
    lOCATION = json['LOCATION'];
    cREATEDDATE = json['CREATED_DATE'];
    rEASONFORREJECT = json['REASON_FOR_REJECT'];
    pAYMENTSTATUS = json['PAYMENT_STATUS'];
    wARDID = json['WARD_ID'];
    wARDNAME = json['WARD_NAME'];
    cIRCLEID = json['CIRCLE_ID'];
    cIRCLENAME = json['CIRCLE_NAME'];
    zONEID = json['ZONE_ID'];
    zONENAME = json['ZONE_NAME'];
    lANDMARK = json['LANDMARK'];
    iMAGE1PATH = json['IMAGE1_PATH'];
    sTATUS = json['STATUS'];
    tYPEOFWASTE = json['TYPE_OF_WASTE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TICKET_ID'] = this.tICKETID;
    data['LOCATION'] = this.lOCATION;
    data['CREATED_DATE'] = this.cREATEDDATE;
    data['REASON_FOR_REJECT'] = this.rEASONFORREJECT;
    data['PAYMENT_STATUS'] = this.pAYMENTSTATUS;
    data['WARD_ID'] = this.wARDID;
    data['WARD_NAME'] = this.wARDNAME;
    data['CIRCLE_ID'] = this.cIRCLEID;
    data['CIRCLE_NAME'] = this.cIRCLENAME;
    data['ZONE_ID'] = this.zONEID;
    data['ZONE_NAME'] = this.zONENAME;
    data['LANDMARK'] = this.lANDMARK;
    data['IMAGE1_PATH'] = this.iMAGE1PATH;
    data['STATUS'] = this.sTATUS;
    data['TYPE_OF_WASTE'] = this.tYPEOFWASTE;
    return data;
  }
}
