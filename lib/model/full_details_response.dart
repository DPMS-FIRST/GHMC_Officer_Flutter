class GrievanceFullDetails {
  String? status;
  String? ward;
  List<Grievance>? grievance;

  GrievanceFullDetails({this.status, this.ward, this.grievance});

  GrievanceFullDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    ward = json['ward'];
    if (json['grievance'] != null) {
      grievance = <Grievance>[];
      json['grievance'].forEach((v) {
        grievance!.add(new Grievance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['ward'] = this.ward;
    if (this.grievance != null) {
      data['grievance'] = this.grievance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Grievance {
  String? id;
  String? type;
  String? timestamp;
  String? status;
  String? photo;
  String? photo2;
  String? photo3;
  String? coulurcode;

  Grievance(
      {this.id,
      this.type,
      this.timestamp,
      this.status,
      this.photo,
      this.photo2,
      this.photo3,
      this.coulurcode});

  Grievance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    timestamp = json['timestamp'];
    status = json['status'];
    photo = json['photo'];
    photo2 = json['photo2'];
    photo3 = json['photo3'];
    coulurcode = json['coulurcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['photo'] = this.photo;
    data['photo2'] = this.photo2;
    data['photo3'] = this.photo3;
    data['coulurcode'] = this.coulurcode;
    return data;
  }
}
