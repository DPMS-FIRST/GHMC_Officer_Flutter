class UserListRequest {
  String? userid;
  String? password;
  String? uid;
  String? typeId;
  String? slftype;

  UserListRequest(
      {this.userid, this.password, this.uid, this.typeId, this.slftype});

  UserListRequest.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    password = json['password'];
    uid = json['uid'];
    typeId = json['type_id'];
    slftype = json['slftype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['password'] = this.password;
    data['uid'] = this.uid;
    data['type_id'] = this.typeId;
    data['slftype'] = this.slftype;
    return data;
  }
}
