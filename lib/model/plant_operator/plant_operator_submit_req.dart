class PlantOperatorSubmitReq {
  String? cNDWGRIEVANCEID;
  String? eMPLOYEEID;
  String? dEVICEID;
  String? tOKENID;
  String? vEHICLENUMBER;
  String? gROSSWT;
  String? tAREWT;
  String? nETWT;

  PlantOperatorSubmitReq(
      {this.cNDWGRIEVANCEID,
      this.eMPLOYEEID,
      this.dEVICEID,
      this.tOKENID,
      this.vEHICLENUMBER,
      this.gROSSWT,
      this.tAREWT,
      this.nETWT});

  PlantOperatorSubmitReq.fromJson(Map<String, dynamic> json) {
    cNDWGRIEVANCEID = json['CNDW_GRIEVANCE_ID'];
    eMPLOYEEID = json['EMPLOYEE_ID'];
    dEVICEID = json['DEVICEID'];
    tOKENID = json['TOKEN_ID'];
    vEHICLENUMBER = json['VEHICLE_NUMBER'];
    gROSSWT = json['GROSS_WT'];
    tAREWT = json['TARE_WT'];
    nETWT = json['NET_WT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CNDW_GRIEVANCE_ID'] = this.cNDWGRIEVANCEID;
    data['EMPLOYEE_ID'] = this.eMPLOYEEID;
    data['DEVICEID'] = this.dEVICEID;
    data['TOKEN_ID'] = this.tOKENID;
    data['VEHICLE_NUMBER'] = this.vEHICLENUMBER;
    data['GROSS_WT'] = this.gROSSWT;
    data['TARE_WT'] = this.tAREWT;
    data['NET_WT'] = this.nETWT;
    return data;
  }
}