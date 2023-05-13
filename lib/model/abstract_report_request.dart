class AbstractReportRequest {
  String? userid;
  String? password;
  String? uid;
  String? typeId;

  AbstractReportRequest({this.userid, this.password, this.uid, this.typeId});

  AbstractReportRequest.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    password = json['password'];
    uid = json['uid'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['password'] = this.password;
    data['uid'] = this.uid;
    data['type_id'] = this.typeId;
    return data;
  }
}
