class RequestByAmohResponse {
  String? sTATUSCODE;
  String? sTATUSMESSAGE;
  List<CitizenList>? citizenList;

  RequestByAmohResponse(
      {this.sTATUSCODE, this.sTATUSMESSAGE, this.citizenList});

  RequestByAmohResponse.fromJson(Map<String, dynamic> json) {
    sTATUSCODE = json['STATUS_CODE'];
    sTATUSMESSAGE = json['STATUS_MESSAGE'];
    if (json['CitizenList'] != null) {
      citizenList = <CitizenList>[];
      json['CitizenList'].forEach((v) {
        citizenList!.add(new CitizenList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS_CODE'] = this.sTATUSCODE;
    data['STATUS_MESSAGE'] = this.sTATUSMESSAGE;
    if (this.citizenList != null) {
      data['CitizenList'] = this.citizenList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CitizenList {
  String? tICKETID;
  String? lOCATION;
  String? iMAGE1PATH;
  String? eSTWT;
  String? cREATEDDATE;
  String? sTATUS;
  String? sTATUSID;
  String? pAYMENTSTATUSID;
  String? pAYMENTSTATUS;

  CitizenList(
      {this.tICKETID,
      this.lOCATION,
      this.iMAGE1PATH,
      this.eSTWT,
      this.cREATEDDATE,
      this.sTATUS,
      this.sTATUSID,
      this.pAYMENTSTATUSID,
      this.pAYMENTSTATUS});

  CitizenList.fromJson(Map<String, dynamic> json) {
    tICKETID = json['TICKET_ID'];
    lOCATION = json['LOCATION'];
    iMAGE1PATH = json['IMAGE1_PATH'];
    eSTWT = json['EST_WT'];
    cREATEDDATE = json['CREATED_DATE'];
    sTATUS = json['STATUS'];
    sTATUSID = json['STATUS_ID'];
    pAYMENTSTATUSID = json['PAYMENT_STATUS_ID'];
    pAYMENTSTATUS = json['PAYMENT_STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TICKET_ID'] = this.tICKETID;
    data['LOCATION'] = this.lOCATION;
    data['IMAGE1_PATH'] = this.iMAGE1PATH;
    data['EST_WT'] = this.eSTWT;
    data['CREATED_DATE'] = this.cREATEDDATE;
    data['STATUS'] = this.sTATUS;
    data['STATUS_ID'] = this.sTATUSID;
    data['PAYMENT_STATUS_ID'] = this.pAYMENTSTATUSID;
    data['PAYMENT_STATUS'] = this.pAYMENTSTATUS;
    return data;
  }
}
