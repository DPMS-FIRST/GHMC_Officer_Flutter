class raiseGrievanceResponse {
  String? status;
  String? tag;
  List<ROW>? rOW;

  raiseGrievanceResponse({this.status, this.tag, this.rOW});

  raiseGrievanceResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    tag = json['tag'];
    if (json['ROW'] != null) {
      rOW = <ROW>[];
      json['ROW'].forEach((v) {
        rOW!.add(new ROW.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['tag'] = this.tag;
    if (this.rOW != null) {
      data['ROW'] = this.rOW!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ROW {
  String? rOWORDER;
  String? gRIEVANCEID;
  String? cNAME;
  String? iURL;
  String? oRDER1;

  ROW({this.rOWORDER, this.gRIEVANCEID, this.cNAME, this.iURL, this.oRDER1});

  ROW.fromJson(Map<String, dynamic> json) {
    rOWORDER = json['ROWORDER'];
    gRIEVANCEID = json['GRIEVANCE_ID'];
    cNAME = json['C_NAME'];
    iURL = json['I_URL'];
    oRDER1 = json['ORDER1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ROWORDER'] = this.rOWORDER;
    data['GRIEVANCE_ID'] = this.gRIEVANCEID;
    data['C_NAME'] = this.cNAME;
    data['I_URL'] = this.iURL;
    data['ORDER1'] = this.oRDER1;
    return data;
  }
}