class ShowNotificationRequest {
  String? userid;
  String? password;
  String? mobileno;

  ShowNotificationRequest({this.userid, this.password, this.mobileno});

  ShowNotificationRequest.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    password = json['password'];
    mobileno = json['mobileno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['password'] = this.password;
    data['mobileno'] = this.mobileno;
    return data;
  }
}
