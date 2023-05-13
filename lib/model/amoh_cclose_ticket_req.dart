class AmohConcessionerCloseTicketSubmitRequest {
  String? cNDWGRIEVANCEID;
  String? eMPLOYEEID;
  String? dEVICEID;
  String? tOKENID;
  String? iSREASSIGN;
  String? rEMARKS;

  AmohConcessionerCloseTicketSubmitRequest(
      {this.cNDWGRIEVANCEID,
      this.eMPLOYEEID,
      this.dEVICEID,
      this.tOKENID,
      this.iSREASSIGN,
      this.rEMARKS});

  AmohConcessionerCloseTicketSubmitRequest.fromJson(Map<String, dynamic> json) {
    cNDWGRIEVANCEID = json['CNDW_GRIEVANCE_ID'];
    eMPLOYEEID = json['EMPLOYEE_ID'];
    dEVICEID = json['DEVICEID'];
    tOKENID = json['TOKEN_ID'];
    iSREASSIGN = json['IS_REASSIGN'];
    rEMARKS = json['REMARKS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CNDW_GRIEVANCE_ID'] = this.cNDWGRIEVANCEID;
    data['EMPLOYEE_ID'] = this.eMPLOYEEID;
    data['DEVICEID'] = this.dEVICEID;
    data['TOKEN_ID'] = this.tOKENID;
    data['IS_REASSIGN'] = this.iSREASSIGN;
    data['REMARKS'] = this.rEMARKS;
    return data;
  }
}
