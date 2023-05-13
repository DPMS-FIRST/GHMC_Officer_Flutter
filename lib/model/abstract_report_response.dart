class AbstractReportResponse {
  String? status;
  String? flag;
  String? tOTALRECEIVED;
  String? tOTALPENDING;
  String? tOTALUNDERPROCESS;
  String? tOTALCLOSED;
  String? tOTALNONGHMC;
  String? tOTALFUNDRELATED;

  AbstractReportResponse(
      {this.status,
      this.flag,
      this.tOTALRECEIVED,
      this.tOTALPENDING,
      this.tOTALUNDERPROCESS,
      this.tOTALCLOSED,
      this.tOTALNONGHMC,
      this.tOTALFUNDRELATED});

  AbstractReportResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    flag = json['flag'];
    tOTALRECEIVED = json['TOTAL_RECEIVED'];
    tOTALPENDING = json['TOTAL_PENDING'];
    tOTALUNDERPROCESS = json['TOTAL_UNDER_PROCESS'];
    tOTALCLOSED = json['TOTAL_CLOSED'];
    tOTALNONGHMC = json['TOTAL_NON_GHMC'];
    tOTALFUNDRELATED = json['TOTAL_FUND_RELATED'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['flag'] = this.flag;
    data['TOTAL_RECEIVED'] = this.tOTALRECEIVED;
    data['TOTAL_PENDING'] = this.tOTALPENDING;
    data['TOTAL_UNDER_PROCESS'] = this.tOTALUNDERPROCESS;
    data['TOTAL_CLOSED'] = this.tOTALCLOSED;
    data['TOTAL_NON_GHMC'] = this.tOTALNONGHMC;
    data['TOTAL_FUND_RELATED'] = this.tOTALFUNDRELATED;
    return data;
  }
}
