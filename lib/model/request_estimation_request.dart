class RequestEstimationRequest {
  String? cNDWGRIEVANCEID;
  String? eMPLOYEEID;
  String? dEVICEID;
  String? tOKENID;

  RequestEstimationRequest(
      {this.cNDWGRIEVANCEID, this.eMPLOYEEID, this.dEVICEID, this.tOKENID});

  RequestEstimationRequest.fromJson(Map<String, dynamic> json) {
    cNDWGRIEVANCEID = json['CNDW_GRIEVANCE_ID'];
    eMPLOYEEID = json['EMPLOYEE_ID'];
    dEVICEID = json['DEVICEID'];
    tOKENID = json['TOKEN_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CNDW_GRIEVANCE_ID'] = this.cNDWGRIEVANCEID;
    data['EMPLOYEE_ID'] = this.eMPLOYEEID;
    data['DEVICEID'] = this.dEVICEID;
    data['TOKEN_ID'] = this.tOKENID;
    return data;
  }
}
