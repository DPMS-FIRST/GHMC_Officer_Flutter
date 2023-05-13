class AmohReassignConcessionerRejectedTicketsRequest {
  String? tICKETID;
  String? dEVICEID;
  String? tOKENID;
  String? aMOHEMPID;
  String? iSREASSIGN;
  String? rEMARKSFORREASSIGN;

  AmohReassignConcessionerRejectedTicketsRequest(
      {this.tICKETID,
      this.dEVICEID,
      this.tOKENID,
      this.aMOHEMPID,
      this.iSREASSIGN,
      this.rEMARKSFORREASSIGN});

  AmohReassignConcessionerRejectedTicketsRequest.fromJson(
      Map<String, dynamic> json) {
    tICKETID = json['TICKET_ID'];
    dEVICEID = json['DEVICEID'];
    tOKENID = json['TOKEN_ID'];
    aMOHEMPID = json['AMOH_EMPID'];
    iSREASSIGN = json['IS_REASSIGN'];
    rEMARKSFORREASSIGN = json['REMARKS_FOR_REASSIGN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TICKET_ID'] = this.tICKETID;
    data['DEVICEID'] = this.dEVICEID;
    data['TOKEN_ID'] = this.tOKENID;
    data['AMOH_EMPID'] = this.aMOHEMPID;
    data['IS_REASSIGN'] = this.iSREASSIGN;
    data['REMARKS_FOR_REASSIGN'] = this.rEMARKSFORREASSIGN;
    return data;
  }
}
