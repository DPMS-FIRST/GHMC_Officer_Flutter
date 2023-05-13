class UserDetailsResponse {
  String? status;
  String? empName;
  String? designation;
  String? emplevel;
  String? ward;
  String? wing;
  List<Dashboard>? dashboard;

  UserDetailsResponse(
      {this.status,
      this.empName,
      this.designation,
      this.emplevel,
      this.ward,
      this.wing,
      this.dashboard});

  UserDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    empName = json['emp_name'];
    designation = json['designation'];
    emplevel = json['emplevel'];
    ward = json['ward'];
    wing = json['wing'];
    if (json['dashboard'] != null) {
      dashboard = <Dashboard>[];
      json['dashboard'].forEach((v) {
        dashboard!.add(new Dashboard.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['emp_name'] = this.empName;
    data['designation'] = this.designation;
    data['emplevel'] = this.emplevel;
    data['ward'] = this.ward;
    data['wing'] = this.wing;
    if (this.dashboard != null) {
      data['dashboard'] = this.dashboard!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dashboard {
  String? typeId;
  String? typeName;
  String? gcount;

  Dashboard({this.typeId, this.typeName, this.gcount});

  Dashboard.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    typeName = json['type_name'];
    gcount = json['gcount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_id'] = this.typeId;
    data['type_name'] = this.typeName;
    data['gcount'] = this.gcount;
    return data;
  }
}
