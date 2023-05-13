class CInchargeTicketListRes {
  String? sTATUSCODE;
  String? sTATUSMESSAGE;
  List< ChargeTicketList>? ticketList;

  CInchargeTicketListRes(
      {this.sTATUSCODE, this.sTATUSMESSAGE, this.ticketList});

  CInchargeTicketListRes.fromJson(Map<String, dynamic> json) {
    sTATUSCODE = json['STATUS_CODE'];
    sTATUSMESSAGE = json['STATUS_MESSAGE'];
    if (json['TicketList'] != null) {
      ticketList = <ChargeTicketList>[];
      json['TicketList'].forEach((v) {
        ticketList!.add(new ChargeTicketList.fromJson(v));
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

class ChargeTicketList {
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
  String? cITIZENRAISEDDATE;
  String? aMOHFORWARDEDDATE;
  String? lATITUDE;
  String? lONGITUDE;
  String? tYPEOFWASTE;
  List<CInchargeVehicleList>? vehicleList;

  ChargeTicketList(
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
      this.cITIZENRAISEDDATE,
      this.aMOHFORWARDEDDATE,
      this.lATITUDE,
      this.lONGITUDE,
      this.tYPEOFWASTE,
      this.vehicleList});

  ChargeTicketList.fromJson(Map<String, dynamic> json) {
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
    cITIZENRAISEDDATE = json['CITIZEN_RAISED_DATE'];
    aMOHFORWARDEDDATE = json['AMOH_FORWARDED_DATE'];
    lATITUDE = json['LATITUDE'];
    lONGITUDE = json['LONGITUDE'];
    tYPEOFWASTE = json['TYPE_OF_WASTE'];
    if (json['vehicleList'] != null) {
      vehicleList = <CInchargeVehicleList>[];
      json['vehicleList'].forEach((v) {
        vehicleList!.add(new CInchargeVehicleList.fromJson(v));
      });
    }
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
    data['CITIZEN_RAISED_DATE'] = this.cITIZENRAISEDDATE;
    data['AMOH_FORWARDED_DATE'] = this.aMOHFORWARDEDDATE;
    data['LATITUDE'] = this.lATITUDE;
    data['LONGITUDE'] = this.lONGITUDE;
    data['TYPE_OF_WASTE'] = this.tYPEOFWASTE;
    if (this.vehicleList != null) {
      data['vehicleList'] = this.vehicleList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CInchargeVehicleList {
  String? vEHICLETYPEID;
  String? vEHICLETYPE;
  String? nOOFVEHICLES;
  String? aMOUNT;
  String? vehicleDetails;

  CInchargeVehicleList(
      {this.vEHICLETYPEID,
      this.vEHICLETYPE,
      this.nOOFVEHICLES,
      this.aMOUNT,
      this.vehicleDetails});

  CInchargeVehicleList.fromJson(Map<String, dynamic> json) {
    vEHICLETYPEID = json['VEHICLE_TYPE_ID'];
    vEHICLETYPE = json['VEHICLE_TYPE'];
    nOOFVEHICLES = json['NO_OF_VEHICLES'];
    aMOUNT = json['AMOUNT'];
    vehicleDetails = json['vehicleDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VEHICLE_TYPE_ID'] = this.vEHICLETYPEID;
    data['VEHICLE_TYPE'] = this.vEHICLETYPE;
    data['NO_OF_VEHICLES'] = this.nOOFVEHICLES;
    data['AMOUNT'] = this.aMOUNT;
    data['vehicleDetails'] = this.vehicleDetails;
    return data;
  }
}
