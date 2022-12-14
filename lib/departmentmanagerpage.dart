import 'package:flutter/material.dart';
import 'package:w11_biruni_flutterapp/department.dart';

class DepartmentManagerPage extends StatefulWidget {
  DepartmentManagerPage({super.key, this.department});

  Department? department;

  @override
  State<DepartmentManagerPage> createState() => _DepartmentManagerPageState();
}

class _DepartmentManagerPageState extends State<DepartmentManagerPage> {
  @override
  Widget build(BuildContext context) {
    var department = widget.department;

    return Container(
      child: (department == null
          ? Text("for insert")
          : Text(department!.departmentname!)),
    );
  }
}
