import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/student.dart';

class StorageService {
  static const String studentsKey = 'students';

  static Future<void> saveStudents(List<Student> students) async {
    final preferences = await SharedPreferences.getInstance();

    final studentData = students.map((student) => student.toMap()).toList();

    await preferences.setString(studentsKey, jsonEncode(studentData));
  }

  static Future<List<Student>> loadStudents() async {
    final preferences = await SharedPreferences.getInstance();

    final storedData = preferences.getString(studentsKey);

    if (storedData == null) {
      return [];
    }

    final List<dynamic> studentData = jsonDecode(storedData);

    return studentData
        .map((data) => Student.fromMap(Map<String, dynamic>.from(data)))
        .toList();
  }
}
