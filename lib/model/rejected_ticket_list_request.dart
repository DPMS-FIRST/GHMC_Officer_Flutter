class RejectedTicketsListRequest {
  String? aMOHEMPID;
  String? aMOHEMPWARDID;
  String? dEVICEID;
  String? tOKENID;

  RejectedTicketsListRequest(
      {this.aMOHEMPID, this.aMOHEMPWARDID, this.dEVICEID, this.tOKENID});

  RejectedTicketsListRequest.fromJson(Map<String, dynamic> json) {
    aMOHEMPID = json['AMOH_EMP_ID'];
    aMOHEMPWARDID = json['AMOH_EMP_WARD_ID'];
    dEVICEID = json['DEVICEID'];
    tOKENID = json['TOKEN_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AMOH_EMP_ID'] = this.aMOHEMPID;
    data['AMOH_EMP_WARD_ID'] = this.aMOHEMPWARDID;
    data['DEVICEID'] = this.dEVICEID;
    data['TOKEN_ID'] = this.tOKENID;
    return data;
  }
}
