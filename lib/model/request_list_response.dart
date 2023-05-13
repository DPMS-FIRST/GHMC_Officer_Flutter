class RequestListResponse {
  String? sTATUSCODE;
  String? sTATUSMESSAGE;
  List<AMOHList>? aMOHList;

  RequestListResponse({this.sTATUSCODE, this.sTATUSMESSAGE, this.aMOHList});

  RequestListResponse.fromJson(Map<String, dynamic> json) {
    sTATUSCODE = json['STATUS_CODE'];
    sTATUSMESSAGE = json['STATUS_MESSAGE'];
    if (json['AMOHList'] != null) {
      aMOHList = <AMOHList>[];
      json['AMOHList'].forEach((v) {
        aMOHList!.add(new AMOHList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS_CODE'] = this.sTATUSCODE;
    data['STATUS_MESSAGE'] = this.sTATUSMESSAGE;
    if (this.aMOHList != null) {
      data['AMOHList'] = this.aMOHList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AMOHList {
  String? tICKETID;
  String? lOCATION;
  String? iMAGE1PATH;
  String? eSTWT;
  String? cREATEDDATE;
  String? sTATUS;
  String? lATITUDE;
  String? lONGITUDE;
  String? tYPEOFWASTE;

  AMOHList(
      {this.tICKETID,
      this.lOCATION,
      this.iMAGE1PATH,
      this.eSTWT,
      this.cREATEDDATE,
      this.sTATUS,
      this.lATITUDE,
      this.lONGITUDE,
      this.tYPEOFWASTE});

  AMOHList.fromJson(Map<String, dynamic> json) {
    tICKETID = json['TICKET_ID'];
    lOCATION = json['LOCATION'];
    iMAGE1PATH = json['IMAGE1_PATH'];
    eSTWT = json['EST_WT'];
    cREATEDDATE = json['CREATED_DATE'];
    sTATUS = json['STATUS'];
    lATITUDE = json['LATITUDE'];
    lONGITUDE = json['LONGITUDE'];
    tYPEOFWASTE = json['TYPE_OF_WASTE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TICKET_ID'] = this.tICKETID;
    data['LOCATION'] = this.lOCATION;
    data['IMAGE1_PATH'] = this.iMAGE1PATH;
    data['EST_WT'] = this.eSTWT;
    data['CREATED_DATE'] = this.cREATEDDATE;
    data['STATUS'] = this.sTATUS;
    data['LATITUDE'] = this.lATITUDE;
    data['LONGITUDE'] = this.lONGITUDE;
    data['TYPE_OF_WASTE'] = this.tYPEOFWASTE;
    return data;
  }
}
