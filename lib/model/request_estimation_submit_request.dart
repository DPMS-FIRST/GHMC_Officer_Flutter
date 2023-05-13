class RequestEstimationSubmitRequest {
  String? aMOUNT;
  String? cNDWGRIEVANCEID;
  String? dEVICEID;
  String? eMPLOYEEID;
  String? eSTWT;
  String? iMAGE1PATH;
  List<VEHICLEDETAILS>? vEHICLEDETAILS;

  RequestEstimationSubmitRequest(
      {this.aMOUNT,
      this.cNDWGRIEVANCEID,
      this.dEVICEID,
      this.eMPLOYEEID,
      this.eSTWT,
      this.iMAGE1PATH,
      this.vEHICLEDETAILS});

  RequestEstimationSubmitRequest.fromJson(Map<String, dynamic> json) {
    aMOUNT = json['AMOUNT'];
    cNDWGRIEVANCEID = json['CNDW_GRIEVANCE_ID'];
    dEVICEID = json['DEVICEID'];
    eMPLOYEEID = json['EMPLOYEE_ID'];
    eSTWT = json['EST_WT'];
    iMAGE1PATH = json['IMAGE1_PATH'];
    if (json['VEHICLE_DETAILS'] != null) {
      vEHICLEDETAILS = <VEHICLEDETAILS>[];
      json['VEHICLE_DETAILS'].forEach((v) {
        vEHICLEDETAILS!.add(new VEHICLEDETAILS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AMOUNT'] = this.aMOUNT;
    data['CNDW_GRIEVANCE_ID'] = this.cNDWGRIEVANCEID;
    data['DEVICEID'] = this.dEVICEID;
    data['EMPLOYEE_ID'] = this.eMPLOYEEID;
    data['EST_WT'] = this.eSTWT;
    data['IMAGE1_PATH'] = this.iMAGE1PATH;
    if (this.vEHICLEDETAILS != null) {
      data['VEHICLE_DETAILS'] =
          this.vEHICLEDETAILS!.map((v) => v.toJson()).toList();
    }
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
