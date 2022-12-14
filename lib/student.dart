class Student {
  int? id;
  int? departmentid;
  String? firstname;
  String? lastname;

  String? departmentname;

  Student(
      {this.id,
      required this.departmentid,
      required this.firstname,
      required this.lastname});

  Student.fromJsonObject(Map<String, dynamic> jsonObject) {
    id = jsonObject["id"];
    departmentid = jsonObject["departmentid"];
    firstname = jsonObject["firstname"];
    lastname = jsonObject["lastname"];
  }

  Map<String, dynamic> toJsonObject() {
    return {
      "id": id,
      "departmentid": departmentid,
      "firstname": firstname,
      "lastname": lastname,
    };
  }
}
