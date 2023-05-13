class RaiseRequestRaiseRequestSubmitRequest {
  String? cIRCLEID;
  String? cREATEDBY;
  String? dEVICEID;
  String? eSTWT;
  String? iMAGE1PATH;
  String? iMAGE2PATH;
  String? iMAGE3PATH;
  String? lANDMARK;
  String? lATITUDE;
  String? lONGITUDE;
  String? tOKENID;
  List<VEHICLEDETAILS>? vEHICLEDETAILS;
  String? wARDID;
  String? zONEID;

  RaiseRequestRaiseRequestSubmitRequest(
      {this.cIRCLEID,
      this.cREATEDBY,
      this.dEVICEID,
      this.eSTWT,
      this.iMAGE1PATH,
      this.iMAGE2PATH,
      this.iMAGE3PATH,
      this.lANDMARK,
      this.lATITUDE,
      this.lONGITUDE,
      this.tOKENID,
      this.vEHICLEDETAILS,
      this.wARDID,
      this.zONEID});

  RaiseRequestRaiseRequestSubmitRequest.fromJson(Map<String, dynamic> json) {
    cIRCLEID = json['CIRCLE_ID'];
    cREATEDBY = json['CREATED_BY'];
    dEVICEID = json['DEVICEID'];
    eSTWT = json['EST_WT'];
    iMAGE1PATH = json['IMAGE1_PATH'];
    iMAGE2PATH = json['IMAGE2_PATH'];
    iMAGE3PATH = json['IMAGE3_PATH'];
    lANDMARK = json['LANDMARK'];
    lATITUDE = json['LATITUDE'];
    lONGITUDE = json['LONGITUDE'];
    tOKENID = json['TOKEN_ID'];
    if (json['VEHICLE_DETAILS'] != null) {
      vEHICLEDETAILS = <VEHICLEDETAILS>[];
      json['VEHICLE_DETAILS'].forEach((v) {
        vEHICLEDETAILS!.add(new VEHICLEDETAILS.fromJson(v));
      });
    }
    wARDID = json['WARD_ID'];
    zONEID = json['ZONE_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CIRCLE_ID'] = this.cIRCLEID;
    data['CREATED_BY'] = this.cREATEDBY;
    data['DEVICEID'] = this.dEVICEID;
    data['EST_WT'] = this.eSTWT;
    data['IMAGE1_PATH'] = this.iMAGE1PATH;
    data['IMAGE2_PATH'] = this.iMAGE2PATH;
    data['IMAGE3_PATH'] = this.iMAGE3PATH;
    data['LANDMARK'] = this.lANDMARK;
    data['LATITUDE'] = this.lATITUDE;
    data['LONGITUDE'] = this.lONGITUDE;
    data['TOKEN_ID'] = this.tOKENID;
    if (this.vEHICLEDETAILS != null) {
      data['VEHICLE_DETAILS'] =
          this.vEHICLEDETAILS!.map((v) => v.toJson()).toList();
    }
    data['WARD_ID'] = this.wARDID;
    data['ZONE_ID'] = this.zONEID;
    return data;
  }
}

class VEHICLEDETAILS {
  String? nOOFTRIPS;
  String? vEHICLETYPEID;

  VEHICLEDETAILS({this.nOOFTRIPS, this.vEHICLETYPEID});

  VEHICLEDETAILS.fromJson(Map<String, dynamic> json) {
    nOOFTRIPS = json['NO_OF_TRIPS'];
    vEHICLETYPEID = json['VEHICLE_TYPE_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NO_OF_TRIPS'] = this.nOOFTRIPS;
    data['VEHICLE_TYPE_ID'] = this.vEHICLETYPEID;
    return data;
  }
}
