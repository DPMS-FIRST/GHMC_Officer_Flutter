class DashboardResponse {
  String? status;
  String? tag;
  List<GrievanceRow>? row;

  DashboardResponse({this.status, this.tag, this.row});

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    tag = json['tag'];
    if (json['ROW'] != null) {
      row = <GrievanceRow>[];
      json['ROW'].forEach((v) {
        row!.add(GrievanceRow.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['tag'] = tag;
    if (row != null) {
      data['ROW'] = row!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GrievanceRow {
  String? total;
  String? sLF;
  String? nONSLF;

  GrievanceRow({this.total, this.sLF, this.nONSLF});

  GrievanceRow.fromJson(Map<String, dynamic> json) {
    total = json['Total'];
    sLF = json['SLF'];
    nONSLF = json['NON SLF'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Total'] = total;
    data['SLF'] = sLF;
    data['NON SLF'] = nONSLF;
    return data;
  }
}
