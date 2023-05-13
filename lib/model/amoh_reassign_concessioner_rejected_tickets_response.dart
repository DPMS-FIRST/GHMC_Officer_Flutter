class AmohReassignConcessionerRejectedTicketsResponse {
  String? sTATUSCODE;
  String? sTATUSMESSAGE;
  String? tICKETID;

  AmohReassignConcessionerRejectedTicketsResponse(
      {this.sTATUSCODE, this.sTATUSMESSAGE, this.tICKETID});

  AmohReassignConcessionerRejectedTicketsResponse.fromJson(
      Map<String, dynamic> json) {
    sTATUSCODE = json['STATUS_CODE'];
    sTATUSMESSAGE = json['STATUS_MESSAGE'];
    tICKETID = json['TICKET_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS_CODE'] = this.sTATUSCODE;
    data['STATUS_MESSAGE'] = this.sTATUSMESSAGE;
    data['TICKET_ID'] = this.tICKETID;
    return data;
  }
}
