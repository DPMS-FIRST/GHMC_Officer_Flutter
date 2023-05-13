class CorporatorListResponse {
  String? status;
  String? tag;
  List<ROW>? rOW;

  CorporatorListResponse({this.status, this.tag, this.rOW});

  CorporatorListResponse.fromJson(Map<String, dynamic> json) {
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
  String? iMENUID;
  String? mENUNAME;
  String? uRL;

  ROW({this.iMENUID, this.mENUNAME, this.uRL});

  ROW.fromJson(Map<String, dynamic> json) {
    iMENUID = json['I_MENUID'];
    mENUNAME = json['MENUNAME'];
    uRL = json['URL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['I_MENUID'] = this.iMENUID;
    data['MENUNAME'] = this.mENUNAME;
    data['URL'] = this.uRL;
    return data;
  }
}