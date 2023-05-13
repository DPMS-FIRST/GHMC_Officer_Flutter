class GetWard {
  String? status;
  String? tag;
  List<Data>? data;

  GetWard({this.status, this.tag, this.data});

  GetWard.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    tag = json['tag'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['tag'] = this.tag;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? ward;
  String? id;

  Data({this.ward, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    ward = json['ward'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ward'] = this.ward;
    data['id'] = this.id;
    return data;
  }
}