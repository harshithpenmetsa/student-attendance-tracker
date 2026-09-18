import 'package:flutter/material.dart';
import '../models/student.dart';
import 'add_student_screen.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final List<Student> students = [];

  Future<void> openAddStudentScreen() async {
    final Student? newStudent = await Navigator.push<Student>(
      context,
      MaterialPageRoute(builder: (context) => const AddStudentScreen()),
    );

    if (newStudent != null) {
      setState(() {
        students.add(newStudent);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students (${students.length})'),
        centerTitle: true,
      ),

      body: students.isEmpty
          ? const Center(
              child: Text(
                'No students added yet.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),

                    title: Text(
                      student.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Text('Roll Number: ${student.rollNumber}'),

                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: openAddStudentScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}
