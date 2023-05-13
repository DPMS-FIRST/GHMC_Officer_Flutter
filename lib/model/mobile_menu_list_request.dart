class MobileMenuListRequest {
  String? userid;
  String? password;
  String? empid;

  MobileMenuListRequest({this.userid, this.password, this.empid});

  MobileMenuListRequest.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    password = json['password'];
    empid = json['empid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['password'] = this.password;
    data['empid'] = this.empid;
    return data;
  }
}
