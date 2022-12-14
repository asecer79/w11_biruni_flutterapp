class Department {
  int? id;
  String? departmentname;

  Department({this.id, required this.departmentname});

  Department.fromJsonObject(Map<String, dynamic> jsonObject) {
    id = jsonObject["id"];
    departmentname = jsonObject["departmentname"];
  }

  Map<String, dynamic> toJsonObject() {
    return {
      "id": id,
      "departmentname": departmentname,
    };
  }
}


