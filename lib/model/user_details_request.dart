class UserDetailsRequest {
  String? userid;
  String? password;
  String? uid;
  String? mode;
  String? typeId;
  String? slftype;

  UserDetailsRequest(
      {this.userid,
      this.password,
      this.uid,
      this.mode,
      this.typeId,
      this.slftype});

  UserDetailsRequest.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    password = json['password'];
    uid = json['uid'];
    mode = json['mode'];
    typeId = json['type_id'];
    slftype = json['slftype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['password'] = this.password;
    data['uid'] = this.uid;
    data['mode'] = this.mode;
    data['type_id'] = this.typeId;
    data['slftype'] = this.slftype;
    return data;
  }
}