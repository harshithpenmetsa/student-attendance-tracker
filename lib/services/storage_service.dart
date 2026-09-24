import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/student.dart';

class StorageService {
  static const String studentsKey = 'students';

  static Future<void> saveStudents(List<Student> students) async {
    final preferences = await SharedPreferences.getInstance();

    final studentData = students.map((student) {
      return {
        'id': student.id,
        'name': student.name,
        'rollNumber': student.rollNumber,
        'presentDays': student.presentDays,
        'absentDays': student.absentDays,
      };
    }).toList();

    await preferences.setString(studentsKey, jsonEncode(studentData));
  }

  static Future<List<Student>> loadStudents() async {
    final preferences = await SharedPreferences.getInstance();

    final storedData = preferences.getString(studentsKey);

    if (storedData == null) {
      return [];
    }

    final List<dynamic> studentData = jsonDecode(storedData);

    return studentData.map((data) {
      return Student(
        id: data['id'],
        name: data['name'],
        rollNumber: data['rollNumber'],
        presentDays: data['presentDays'],
        absentDays: data['absentDays'],
      );
    }).toList();
  }
}
