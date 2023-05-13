class AmountPaidListResponse {
  String? sTATUSCODE;
  String? sTATUSMESSAGE;
  List<PaidList>? paidList;
  String? vehicleList;

  AmountPaidListResponse(
      {this.sTATUSCODE, this.sTATUSMESSAGE, this.paidList, this.vehicleList});

  AmountPaidListResponse.fromJson(Map<String, dynamic> json) {
    sTATUSCODE = json['STATUS_CODE'];
    sTATUSMESSAGE = json['STATUS_MESSAGE'];
    if (json['PaidList'] != null) {
      paidList = <PaidList>[];
      json['PaidList'].forEach((v) {
        paidList!.add(new PaidList.fromJson(v));
      });
    }
    vehicleList = json['vehicleList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS_CODE'] = this.sTATUSCODE;
    data['STATUS_MESSAGE'] = this.sTATUSMESSAGE;
    if (this.paidList != null) {
      data['PaidList'] = this.paidList!.map((v) => v.toJson()).toList();
    }
    data['vehicleList'] = this.vehicleList;
    return data;
  }
}

class PaidList {
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
  String? vEHICLETYPEID;
  String? iMAGE1PATH;
  String? nOOFVEHICLES;
  String? sTATUS;
  String? tYPEOFWASTE;
  String? vehicleList;
  List<VehicleDetailsList>? vehicleDetailsList;

  PaidList(
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
      this.vEHICLETYPEID,
      this.iMAGE1PATH,
      this.nOOFVEHICLES,
      this.sTATUS,
      this.tYPEOFWASTE,
      this.vehicleList,
      this.vehicleDetailsList});

  PaidList.fromJson(Map<String, dynamic> json) {
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
    vEHICLETYPEID = json['VEHICLE_TYPE_ID'];
    iMAGE1PATH = json['IMAGE1_PATH'];
    nOOFVEHICLES = json['NO_OF_VEHICLES'];
    sTATUS = json['STATUS'];
    tYPEOFWASTE = json['TYPE_OF_WASTE'];
    vehicleList = json['vehicleList'];
    if (json['vehicleDetailsList'] != null) {
      vehicleDetailsList = <VehicleDetailsList>[];
      json['vehicleDetailsList'].forEach((v) {
        vehicleDetailsList!.add(new VehicleDetailsList.fromJson(v));
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
    data['VEHICLE_TYPE_ID'] = this.vEHICLETYPEID;
    data['IMAGE1_PATH'] = this.iMAGE1PATH;
    data['NO_OF_VEHICLES'] = this.nOOFVEHICLES;
    data['STATUS'] = this.sTATUS;
    data['TYPE_OF_WASTE'] = this.tYPEOFWASTE;
    data['vehicleList'] = this.vehicleList;
    if (this.vehicleDetailsList != null) {
      data['vehicleDetailsList'] =
          this.vehicleDetailsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VehicleDetailsList {
  String? vEHICLETYPEID;
  String? vEHICLETYPE;
  String? nOOFVEHICLES;
  String? aMOUNT;
  String? vehicleTripDetails;

  VehicleDetailsList(
      {this.vEHICLETYPEID,
      this.vEHICLETYPE,
      this.nOOFVEHICLES,
      this.aMOUNT,
      this.vehicleTripDetails});

  VehicleDetailsList.fromJson(Map<String, dynamic> json) {
    vEHICLETYPEID = json['VEHICLE_TYPE_ID'];
    vEHICLETYPE = json['VEHICLE_TYPE'];
    nOOFVEHICLES = json['NO_OF_VEHICLES'];
    aMOUNT = json['AMOUNT'];
    vehicleTripDetails = json['vehicleTripDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VEHICLE_TYPE_ID'] = this.vEHICLETYPEID;
    data['VEHICLE_TYPE'] = this.vEHICLETYPE;
    data['NO_OF_VEHICLES'] = this.nOOFVEHICLES;
    data['AMOUNT'] = this.aMOUNT;
    data['vehicleTripDetails'] = this.vehicleTripDetails;
    return data;
  }
}
