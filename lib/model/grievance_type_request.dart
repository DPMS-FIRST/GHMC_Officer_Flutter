class GrievanceTypeRequest {
  String? userid;
  String? password;

  GrievanceTypeRequest({this.userid, this.password});

  GrievanceTypeRequest.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['password'] = this.password;
    return data;
  }
}
