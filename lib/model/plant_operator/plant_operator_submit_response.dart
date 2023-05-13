class PlantOperatorSubmitResponse {
  String? sTATUSCODE;
  String? sTATUSMESSAGE;
  String? cNDWGRIEVANCEID;
  String? oFFICERDETAILS;

  PlantOperatorSubmitResponse(
      {this.sTATUSCODE,
      this.sTATUSMESSAGE,
      this.cNDWGRIEVANCEID,
      this.oFFICERDETAILS});

  PlantOperatorSubmitResponse.fromJson(Map<String, dynamic> json) {
    sTATUSCODE = json['STATUS_CODE'];
    sTATUSMESSAGE = json['STATUS_MESSAGE'];
    cNDWGRIEVANCEID = json['CNDW_GRIEVANCE_ID'];
    oFFICERDETAILS = json['OFFICER_DETAILS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS_CODE'] = this.sTATUSCODE;
    data['STATUS_MESSAGE'] = this.sTATUSMESSAGE;
    data['CNDW_GRIEVANCE_ID'] = this.cNDWGRIEVANCEID;
    data['OFFICER_DETAILS'] = this.oFFICERDETAILS;
    return data;
  }
}