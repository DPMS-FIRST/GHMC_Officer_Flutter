class NewComplaintRequest {
  String? latitude;
  String? longitude;
  String? gid;
  String? password;
  String? userid;

  NewComplaintRequest(
      {this.latitude, this.longitude, this.gid, this.password, this.userid});

  NewComplaintRequest.fromJson(Map<String, dynamic> json) {
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    gid = json['gid'];
    password = json['password'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['gid'] = this.gid;
    data['password'] = this.password;
    data['userid'] = this.userid;
    return data;
  }
}
