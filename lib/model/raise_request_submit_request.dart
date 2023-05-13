class RaiseRequestSubmitRequest {
  String? cNDWGRIEVANCEID;
  String? eMPLOYEEID;
  String? dEVICEID;
  String? tOKENID;
  String? iMAGE1PATH;
  String? eSTWT;
  String? wARDID;

  RaiseRequestSubmitRequest(
      {this.cNDWGRIEVANCEID,
      this.eMPLOYEEID,
      this.dEVICEID,
      this.tOKENID,
      this.iMAGE1PATH,
      this.eSTWT,
      this.wARDID});

  RaiseRequestSubmitRequest.fromJson(Map<String, dynamic> json) {
    cNDWGRIEVANCEID = json['CNDW_GRIEVANCE_ID'];
    eMPLOYEEID = json['EMPLOYEE_ID'];
    dEVICEID = json['DEVICEID'];
    tOKENID = json['TOKEN_ID'];
    iMAGE1PATH = json['IMAGE1_PATH'];
    eSTWT = json['EST_WT'];
    wARDID = json['WARD_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CNDW_GRIEVANCE_ID'] = this.cNDWGRIEVANCEID;
    data['EMPLOYEE_ID'] = this.eMPLOYEEID;
    data['DEVICEID'] = this.dEVICEID;
    data['TOKEN_ID'] = this.tOKENID;
    data['IMAGE1_PATH'] = this.iMAGE1PATH;
    data['EST_WT'] = this.eSTWT;
    data['WARD_ID'] = this.wARDID;
    return data;
  }
}
