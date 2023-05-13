class GrievanceDetailsResponse {
  String? status;
  List<Grievance>? grievance;
  List<Comments>? comments;

  GrievanceDetailsResponse({this.status, this.grievance, this.comments});

  GrievanceDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['grievance'] != null) {
      grievance = <Grievance>[];
      json['grievance'].forEach((v) {
        grievance!.add(new Grievance.fromJson(v));
      });
    }
    if (json['Comments'] != null) {
      comments = <Comments>[];
      json['Comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.grievance != null) {
      data['grievance'] = this.grievance!.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['Comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Grievance {
  String? feedback;
  String? status;
  String? id;
  String? type;
  String? landmark;
  String? photo;
  String? photo2;
  String? photo3;
  String? latlon;
  String? mobileno;
  String? cmobileno;
  String? timeStamp;
  String? gstatus;
  String? userName;
  String? remarks;
  String? assignedto;
  String? subCatId;
  String? statusid;
  String? isFeedback;

  Grievance(
      {this.feedback,
      this.status,
      this.id,
      this.type,
      this.landmark,
      this.photo,
      this.photo2,
      this.photo3,
      this.latlon,
      this.mobileno,
      this.cmobileno,
      this.timeStamp,
      this.gstatus,
      this.userName,
      this.remarks,
      this.assignedto,
      this.subCatId,
      this.statusid,
      this.isFeedback});

  Grievance.fromJson(Map<String, dynamic> json) {
    feedback = json['feedback'];
    status = json['status'];
    id = json['id'];
    type = json['type'];
    landmark = json['landmark'];
    photo = json['photo'];
    photo2 = json['photo2'];
    photo3 = json['photo3'];
    latlon = json['latlon'];
    mobileno = json['mobileno'];
    cmobileno = json['cmobileno'];
    timeStamp = json['time_stamp'];
    gstatus = json['gstatus'];
    userName = json['user_name'];
    remarks = json['remarks'];
    assignedto = json['assignedto'];
    subCatId = json['sub_cat_id'];
    statusid = json['statusid'];
    isFeedback = json['IsFeedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feedback'] = this.feedback;
    data['status'] = this.status;
    data['id'] = this.id;
    data['type'] = this.type;
    data['landmark'] = this.landmark;
    data['photo'] = this.photo;
    data['photo2'] = this.photo2;
    data['photo3'] = this.photo3;
    data['latlon'] = this.latlon;
    data['mobileno'] = this.mobileno;
    data['cmobileno'] = this.cmobileno;
    data['time_stamp'] = this.timeStamp;
    data['gstatus'] = this.gstatus;
    data['user_name'] = this.userName;
    data['remarks'] = this.remarks;
    data['assignedto'] = this.assignedto;
    data['sub_cat_id'] = this.subCatId;
    data['statusid'] = this.statusid;
    data['IsFeedback'] = this.isFeedback;
    return data;
  }
}

class Comments {
  String? flag;
  String? cid;
  String? cdid;
  String? cremarks;
  String? cphoto;
  String? clatlon;
  String? cmobileno;
  String? cuserName;
  String? cstatus;
  String? ctimeStamp;

  Comments(
      {this.flag,
      this.cid,
      this.cdid,
      this.cremarks,
      this.cphoto,
      this.clatlon,
      this.cmobileno,
      this.cuserName,
      this.cstatus,
      this.ctimeStamp});

  Comments.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    cid = json['cid'];
    cdid = json['cdid'];
    cremarks = json['cremarks'];
    cphoto = json['cphoto'];
    clatlon = json['clatlon'];
    cmobileno = json['cmobileno'];
    cuserName = json['cuser_name'];
    cstatus = json['cstatus'];
    ctimeStamp = json['ctime_stamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['cid'] = this.cid;
    data['cdid'] = this.cdid;
    data['cremarks'] = this.cremarks;
    data['cphoto'] = this.cphoto;
    data['clatlon'] = this.clatlon;
    data['cmobileno'] = this.cmobileno;
    data['cuser_name'] = this.cuserName;
    data['cstatus'] = this.cstatus;
    data['ctime_stamp'] = this.ctimeStamp;
    return data;
  }
}
