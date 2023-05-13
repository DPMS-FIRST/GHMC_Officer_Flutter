
class GrievanceUserList {
  String? status;
  String? tag;
  List<ROW>? rOW;

  GrievanceUserList({this.status, this.tag, this.rOW});

  GrievanceUserList.fromJson(Map<String, dynamic> json) {
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
  String? mODEID;
  String? mCOUNT;
  String? cNAME;
  String? iURL;
  String? oRDER1;
  String? eMPID;

  ROW(
      {this.rOWORDER,
      this.mODEID,
      this.mCOUNT,
      this.cNAME,
      this.iURL,
      this.oRDER1,
      this.eMPID});

  ROW.fromJson(Map<String, dynamic> json) {
    rOWORDER = json['ROWORDER'];
    mODEID = json['MODE_ID'];
    mCOUNT = json['MCOUNT'];
    cNAME = json['C_NAME'];
    iURL = json['I_URL'];
    oRDER1 = json['ORDER1'];
    eMPID = json['EMPID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ROWORDER'] = this.rOWORDER;
    data['MODE_ID'] = this.mODEID;
    data['MCOUNT'] = this.mCOUNT;
    data['C_NAME'] = this.cNAME;
    data['I_URL'] = this.iURL;
    data['ORDER1'] = this.oRDER1;
    data['EMPID'] = this.eMPID;
    return data;
  }
}