class WhereAmIRequest {
  String? userid;
  String? password;
  String? latitude;
  String? longitude;

  WhereAmIRequest({this.userid, this.password, this.latitude, this.longitude});

  WhereAmIRequest.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    password = json['password'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['password'] = this.password;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
