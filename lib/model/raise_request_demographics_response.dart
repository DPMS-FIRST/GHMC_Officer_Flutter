class RaiseRequestDemographicsResponse {
  String? sTATUSCODE;
  String? sTATUSMESSAGE;
  String? wARDID;
  String? wARDNAME;
  String? cIRCLEID;
  String? cIRCLENAME;
  String? zONEID;
  String? zONENAME;

  RaiseRequestDemographicsResponse(
      {this.sTATUSCODE,
      this.sTATUSMESSAGE,
      this.wARDID,
      this.wARDNAME,
      this.cIRCLEID,
      this.cIRCLENAME,
      this.zONEID,
      this.zONENAME});

  RaiseRequestDemographicsResponse.fromJson(Map<String, dynamic> json) {
    sTATUSCODE = json['STATUS_CODE'];
    sTATUSMESSAGE = json['STATUS_MESSAGE'];
    wARDID = json['WARD_ID'];
    wARDNAME = json['WARD_NAME'];
    cIRCLEID = json['CIRCLE_ID'];
    cIRCLENAME = json['CIRCLE_NAME'];
    zONEID = json['ZONE_ID'];
    zONENAME = json['ZONE_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS_CODE'] = this.sTATUSCODE;
    data['STATUS_MESSAGE'] = this.sTATUSMESSAGE;
    data['WARD_ID'] = this.wARDID;
    data['WARD_NAME'] = this.wARDNAME;
    data['CIRCLE_ID'] = this.cIRCLEID;
    data['CIRCLE_NAME'] = this.cIRCLENAME;
    data['ZONE_ID'] = this.zONEID;
    data['ZONE_NAME'] = this.zONENAME;
    return data;
  }
}
