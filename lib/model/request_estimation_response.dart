class RequestEstimationResponse {
  String? sTATUSCODE;
  String? sTATUSMESSAGE;
  String? zONEID;
  String? cIRCLEID;
  String? wARDID;
  String? lANDMARK;
  String? vEHICLETYPE;
  String? iMAGE1PATH;
  String? iMAGE2PATH;
  String? iMAGE3PATH;
  String? nOOFVEHICLES;
  String? eSTWT;
  String? cREATEDBY;
  String? cREATEDDATE;
  String? sTATUS;
  String? lATITUDE;
  String? lONGITUDE;
  String? tYPEOFWASTE;
  List<VehicleList>? vehicleList;

  RequestEstimationResponse(
      {this.sTATUSCODE,
      this.sTATUSMESSAGE,
      this.zONEID,
      this.cIRCLEID,
      this.wARDID,
      this.lANDMARK,
      this.vEHICLETYPE,
      this.iMAGE1PATH,
      this.iMAGE2PATH,
      this.iMAGE3PATH,
      this.nOOFVEHICLES,
      this.eSTWT,
      this.cREATEDBY,
      this.cREATEDDATE,
      this.sTATUS,
      this.lATITUDE,
      this.lONGITUDE,
      this.tYPEOFWASTE,
      this.vehicleList});

  RequestEstimationResponse.fromJson(Map<String, dynamic> json) {
    sTATUSCODE = json['STATUS_CODE'];
    sTATUSMESSAGE = json['STATUS_MESSAGE'];
    zONEID = json['ZONE_ID'];
    cIRCLEID = json['CIRCLE_ID'];
    wARDID = json['WARD_ID'];
    lANDMARK = json['LANDMARK'];
    vEHICLETYPE = json['VEHICLE_TYPE'];
    iMAGE1PATH = json['IMAGE1_PATH'];
    iMAGE2PATH = json['IMAGE2_PATH'];
    iMAGE3PATH = json['IMAGE3_PATH'];
    nOOFVEHICLES = json['NO_OF_VEHICLES'];
    eSTWT = json['EST_WT'];
    cREATEDBY = json['CREATED_BY'];
    cREATEDDATE = json['CREATED_DATE'];
    sTATUS = json['STATUS'];
    lATITUDE = json['LATITUDE'];
    lONGITUDE = json['LONGITUDE'];
    tYPEOFWASTE = json['TYPE_OF_WASTE'];
    if (json['vehicleList'] != null) {
      vehicleList = <VehicleList>[];
      json['vehicleList'].forEach((v) {
        vehicleList!.add(new VehicleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS_CODE'] = this.sTATUSCODE;
    data['STATUS_MESSAGE'] = this.sTATUSMESSAGE;
    data['ZONE_ID'] = this.zONEID;
    data['CIRCLE_ID'] = this.cIRCLEID;
    data['WARD_ID'] = this.wARDID;
    data['LANDMARK'] = this.lANDMARK;
    data['VEHICLE_TYPE'] = this.vEHICLETYPE;
    data['IMAGE1_PATH'] = this.iMAGE1PATH;
    data['IMAGE2_PATH'] = this.iMAGE2PATH;
    data['IMAGE3_PATH'] = this.iMAGE3PATH;
    data['NO_OF_VEHICLES'] = this.nOOFVEHICLES;
    data['EST_WT'] = this.eSTWT;
    data['CREATED_BY'] = this.cREATEDBY;
    data['CREATED_DATE'] = this.cREATEDDATE;
    data['STATUS'] = this.sTATUS;
    data['LATITUDE'] = this.lATITUDE;
    data['LONGITUDE'] = this.lONGITUDE;
    data['TYPE_OF_WASTE'] = this.tYPEOFWASTE;
    if (this.vehicleList != null) {
      data['vehicleList'] = this.vehicleList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VehicleList {
  String? vEHICLETYPEID;
  String? vEHICLETYPE;
  String? nOOFVEHICLES;
  String? aMOUNT;

  VehicleList(
      {this.vEHICLETYPEID, this.vEHICLETYPE, this.nOOFVEHICLES, this.aMOUNT});

  VehicleList.fromJson(Map<String, dynamic> json) {
    vEHICLETYPEID = json['VEHICLE_TYPE_ID'];
    vEHICLETYPE = json['VEHICLE_TYPE'];
    nOOFVEHICLES = json['NO_OF_VEHICLES'];
    aMOUNT = json['AMOUNT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VEHICLE_TYPE_ID'] = this.vEHICLETYPEID;
    data['VEHICLE_TYPE'] = this.vEHICLETYPE;
    data['NO_OF_VEHICLES'] = this.nOOFVEHICLES;
    data['AMOUNT'] = this.aMOUNT;
    return data;
  }
}
