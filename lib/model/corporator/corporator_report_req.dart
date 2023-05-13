
class CorporatorReportRequest {
  String? fROMDATE;
  String? tODATE;
  String? wARD;
  String? mENUID;
  String? tYPE;

  CorporatorReportRequest({this.fROMDATE, this.tODATE, this.wARD, this.mENUID, this.tYPE});

  CorporatorReportRequest.fromJson(Map<String, dynamic> json) {
    fROMDATE = json['FROMDATE'];
    tODATE = json['TODATE'];
    wARD = json['WARD'];
    mENUID = json['MENUID'];
    tYPE = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FROMDATE'] = this.fROMDATE;
    data['TODATE'] = this.tODATE;
    data['WARD'] = this.wARD;
    data['MENUID'] = this.mENUID;
    data['Type'] = this.tYPE;
    return data;
  }
}