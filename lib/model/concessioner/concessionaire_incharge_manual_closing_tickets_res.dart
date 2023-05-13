class ConcessionaireInchargeManualClosingTicketsListRes {
  String? sTATUSCODE;
  String? sTATUSMESSAGE;
  List<TicketList>? ticketList;

  ConcessionaireInchargeManualClosingTicketsListRes(
      {this.sTATUSCODE, this.sTATUSMESSAGE, this.ticketList});

  ConcessionaireInchargeManualClosingTicketsListRes.fromJson(
      Map<String, dynamic> json) {
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
  String? eSTWT;
  String? pAYMENTSTATUS;
  String? wARDID;
  String? wARDNAME;
  String? cIRCLEID;
  String? cIRCLENAME;
  String? zONEID;
  String? zONENAME;
  String? lANDMARK;
  String? vEHICLETYPE;
  String? iMAGE1PATH;
  String? nOOFVEHICLES;
  String? sTATUS;
  String? lATITUDE;
  String? lONGITUDE;
  String? tYPEOFWASTE;
  String? listVehicles;

  TicketList(
      {this.tICKETID,
      this.lOCATION,
      this.cREATEDDATE,
      this.eSTWT,
      this.pAYMENTSTATUS,
      this.wARDID,
      this.wARDNAME,
      this.cIRCLEID,
      this.cIRCLENAME,
      this.zONEID,
      this.zONENAME,
      this.lANDMARK,
      this.vEHICLETYPE,
      this.iMAGE1PATH,
      this.nOOFVEHICLES,
      this.sTATUS,
      this.lATITUDE,
      this.lONGITUDE,
      this.tYPEOFWASTE,
      this.listVehicles});

  TicketList.fromJson(Map<String, dynamic> json) {
    tICKETID = json['TICKET_ID'];
    lOCATION = json['LOCATION'];
    cREATEDDATE = json['CREATED_DATE'];
    eSTWT = json['EST_WT'];
    pAYMENTSTATUS = json['PAYMENT_STATUS'];
    wARDID = json['WARD_ID'];
    wARDNAME = json['WARD_NAME'];
    cIRCLEID = json['CIRCLE_ID'];
    cIRCLENAME = json['CIRCLE_NAME'];
    zONEID = json['ZONE_ID'];
    zONENAME = json['ZONE_NAME'];
    lANDMARK = json['LANDMARK'];
    vEHICLETYPE = json['VEHICLE_TYPE'];
    iMAGE1PATH = json['IMAGE1_PATH'];
    nOOFVEHICLES = json['NO_OF_VEHICLES'];
    sTATUS = json['STATUS'];
    lATITUDE = json['LATITUDE'];
    lONGITUDE = json['LONGITUDE'];
    tYPEOFWASTE = json['TYPE_OF_WASTE'];
    listVehicles = json['listVehicles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TICKET_ID'] = this.tICKETID;
    data['LOCATION'] = this.lOCATION;
    data['CREATED_DATE'] = this.cREATEDDATE;
    data['EST_WT'] = this.eSTWT;
    data['PAYMENT_STATUS'] = this.pAYMENTSTATUS;
    data['WARD_ID'] = this.wARDID;
    data['WARD_NAME'] = this.wARDNAME;
    data['CIRCLE_ID'] = this.cIRCLEID;
    data['CIRCLE_NAME'] = this.cIRCLENAME;
    data['ZONE_ID'] = this.zONEID;
    data['ZONE_NAME'] = this.zONENAME;
    data['LANDMARK'] = this.lANDMARK;
    data['VEHICLE_TYPE'] = this.vEHICLETYPE;
    data['IMAGE1_PATH'] = this.iMAGE1PATH;
    data['NO_OF_VEHICLES'] = this.nOOFVEHICLES;
    data['STATUS'] = this.sTATUS;
    data['LATITUDE'] = this.lATITUDE;
    data['LONGITUDE'] = this.lONGITUDE;
    data['TYPE_OF_WASTE'] = this.tYPEOFWASTE;
    data['listVehicles'] = this.listVehicles;
    return data;
  }
}
