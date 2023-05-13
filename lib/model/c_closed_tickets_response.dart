class ConcessionerClosedTicketsListResponse {
  String? sTATUSCODE;
  String? sTATUSMESSAGE;
  List<TicketList>? ticketList;

  ConcessionerClosedTicketsListResponse(
      {this.sTATUSCODE, this.sTATUSMESSAGE, this.ticketList});

  ConcessionerClosedTicketsListResponse.fromJson(Map<String, dynamic> json) {
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
  String? tICKETRAISEDDATE;
  String? tICKETCLOSEDDATE;
  String? zONEID;
  String? zONENAME;
  String? cIRCLEID;
  String? cIRCLENAME;
  String? wARDID;
  String? wARDNAME;
  String? cONCESSIONERNAME;
  String? tYPEOFWASTE;
  String? sTATUS;
  String? iMAGE1PATH;
  List<ListVehicles>? listVehicles;

  TicketList(
      {this.tICKETID,
      this.lOCATION,
      this.tICKETRAISEDDATE,
      this.tICKETCLOSEDDATE,
      this.zONEID,
      this.zONENAME,
      this.cIRCLEID,
      this.cIRCLENAME,
      this.wARDID,
      this.wARDNAME,
      this.cONCESSIONERNAME,
      this.tYPEOFWASTE,
      this.sTATUS,
      this.iMAGE1PATH,
      this.listVehicles});

  TicketList.fromJson(Map<String, dynamic> json) {
    tICKETID = json['TICKET_ID'];
    lOCATION = json['LOCATION'];
    tICKETRAISEDDATE = json['TICKET_RAISED_DATE'];
    tICKETCLOSEDDATE = json['TICKET_CLOSED_DATE'];
    zONEID = json['ZONE_ID'];
    zONENAME = json['ZONE_NAME'];
    cIRCLEID = json['CIRCLE_ID'];
    cIRCLENAME = json['CIRCLE_NAME'];
    wARDID = json['WARD_ID'];
    wARDNAME = json['WARD_NAME'];
    cONCESSIONERNAME = json['CONCESSIONER_NAME'];
    tYPEOFWASTE = json['TYPE_OF_WASTE'];
    sTATUS = json['STATUS'];
    iMAGE1PATH = json['IMAGE1_PATH'];
    if (json['listVehicles'] != null) {
      listVehicles = <ListVehicles>[];
      json['listVehicles'].forEach((v) {
        listVehicles!.add(new ListVehicles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TICKET_ID'] = this.tICKETID;
    data['LOCATION'] = this.lOCATION;
    data['TICKET_RAISED_DATE'] = this.tICKETRAISEDDATE;
    data['TICKET_CLOSED_DATE'] = this.tICKETCLOSEDDATE;
    data['ZONE_ID'] = this.zONEID;
    data['ZONE_NAME'] = this.zONENAME;
    data['CIRCLE_ID'] = this.cIRCLEID;
    data['CIRCLE_NAME'] = this.cIRCLENAME;
    data['WARD_ID'] = this.wARDID;
    data['WARD_NAME'] = this.wARDNAME;
    data['CONCESSIONER_NAME'] = this.cONCESSIONERNAME;
    data['TYPE_OF_WASTE'] = this.tYPEOFWASTE;
    data['STATUS'] = this.sTATUS;
    data['IMAGE1_PATH'] = this.iMAGE1PATH;
    if (this.listVehicles != null) {
      data['listVehicles'] = this.listVehicles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListVehicles {
  String? vEHICLENO;
  String? vEHICLEID;
  String? dRIVERNAME;
  String? dRIVERMOBILENUMBER;
  String? bEFORETRIPIMAGE;
  String? aFTERTRIPIMAGE;

  ListVehicles(
      {this.vEHICLENO,
      this.vEHICLEID,
      this.dRIVERNAME,
      this.dRIVERMOBILENUMBER,
      this.bEFORETRIPIMAGE,
      this.aFTERTRIPIMAGE});

  ListVehicles.fromJson(Map<String, dynamic> json) {
    vEHICLENO = json['VEHICLE_NO'];
    vEHICLEID = json['VEHICLE_ID'];
    dRIVERNAME = json['DRIVER_NAME'];
    dRIVERMOBILENUMBER = json['DRIVER_MOBILE_NUMBER'];
    bEFORETRIPIMAGE = json['BEFORE_TRIP_IMAGE'];
    aFTERTRIPIMAGE = json['AFTER_TRIP_IMAGE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VEHICLE_NO'] = this.vEHICLENO;
    data['VEHICLE_ID'] = this.vEHICLEID;
    data['DRIVER_NAME'] = this.dRIVERNAME;
    data['DRIVER_MOBILE_NUMBER'] = this.dRIVERMOBILENUMBER;
    data['BEFORE_TRIP_IMAGE'] = this.bEFORETRIPIMAGE;
    data['AFTER_TRIP_IMAGE'] = this.aFTERTRIPIMAGE;
    return data;
  }
}
