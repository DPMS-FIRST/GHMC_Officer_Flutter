class CClosedListReq {
  String? cONCEMPID;
  String? dEVICEID;
  String? tOKENID;

  CClosedListReq({this.cONCEMPID, this.dEVICEID, this.tOKENID});

  CClosedListReq.fromJson(Map<String, dynamic> json) {
    cONCEMPID = json['CONC_EMP_ID'];
    dEVICEID = json['DEVICEID'];
    tOKENID = json['TOKEN_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CONC_EMP_ID'] = this.cONCEMPID;
    data['DEVICEID'] = this.dEVICEID;
    data['TOKEN_ID'] = this.tOKENID;
    return data;
  }
}
