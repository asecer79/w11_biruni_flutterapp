import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:w11_biruni_flutterapp/department.dart';

class DbContext {
  static Future<Database> _initialize() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, "schooldb_production.db");
    File dbFile = File(path);

    //development
    // if (await databaseExists(path)) {
    //   await deleteDatabase(path);
    // }

    if (!await databaseExists(path)) {
      await Directory(dirname(path)).create(recursive: true);

      ByteData data = await rootBundle.load(join("assets", "schooldb.db"));

      var bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path, readOnly: false);
  }

  static Future<List<Department>> getDepartments() async {
    //sleep(Duration(seconds: 10));

    var db = await _initialize();

    var records = await db.query("departments");

    var departments = records.map<Department>((Map jsonObject) {
      return Department(
          id: jsonObject["id"],
          departmentname: jsonObject["departmentname"].toString());
    }).toList();

    return departments;
  }

  static Future<Department> getDepartment(int id) async {
    var db = await _initialize();

    var jsonObject =
        (await db.query("departments", where: "id=?", whereArgs: [id]))[0];

    var department = Department.fromJsonObject(jsonObject);

    return department;
  }

  static Future<int> insertDepartment(Department department) async {
    var db = await _initialize();
    return await db.insert("departments", department.toJsonObject());
  }

  static Future<int> updateDepartment(Department department) async {
    var db = await _initialize();
    return await db.update("departments", department.toJsonObject(),
        where: "id=?", whereArgs: [department.id]);
  }

  static Future<int> deleteDepartment(int id) async {
    var db = await _initialize();
    //delete from departments where id = 2;
    return await db.delete("departments", where: "id=?", whereArgs: [id]);
  }
}
