import 'package:flutter/material.dart';

import '../models/student.dart';
import '../services/storage_service.dart';
import 'add_student_screen.dart';
import 'student_details_screen.dart';

class StudentListScreen extends StatefulWidget {
  final List<Student> students;

  const StudentListScreen({super.key, required this.students});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  Future<void> openAddStudentScreen() async {
    final Student? newStudent = await Navigator.push<Student>(
      context,
      MaterialPageRoute(builder: (context) => const AddStudentScreen()),
    );

    if (newStudent != null) {
      setState(() {
        widget.students.add(newStudent);
      });

      await StorageService.saveStudents(widget.students);
    }
  }

  Future<void> editStudent(Student student) async {
    final Student? updatedStudent = await Navigator.push<Student>(
      context,
      MaterialPageRoute(
        builder: (context) => AddStudentScreen(student: student),
      ),
    );

    if (updatedStudent != null) {
      setState(() {});

      await StorageService.saveStudents(widget.students);
    }
  }

  Future<void> deleteStudent(Student student) async {
    final bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Student'),
          content: Text('Are you sure you want to delete ${student.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      setState(() {
        widget.students.remove(student);
      });

      await StorageService.saveStudents(widget.students);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('${student.name} deleted')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students (${widget.students.length})'),
        centerTitle: true,
      ),

      body: widget.students.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.people_outline, size: 70),

                  const SizedBox(height: 16),

                  const Text(
                    'No students added yet.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  const Text('Tap the + button to add a student.'),

                  const SizedBox(height: 20),

                  ElevatedButton.icon(
                    onPressed: openAddStudentScreen,
                    icon: const Icon(Icons.person_add),
                    label: const Text('Add Student'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.students.length,
              itemBuilder: (context, index) {
                final student = widget.students[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),

                    title: Text(
                      student.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Text('Roll Number: ${student.rollNumber}'),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              StudentDetailsScreen(student: student),
                        ),
                      ).then((_) {
                        setState(() {});
                      });
                    },

                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          editStudent(student);
                        } else if (value == 'delete') {
                          deleteStudent(student);
                        }
                      },

                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit),
                              SizedBox(width: 10),
                              Text('Edit'),
                            ],
                          ),
                        ),

                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete),
                              SizedBox(width: 10),
                              Text('Delete'),
                            ],
                          ),
                        ),
                      ],
                    ),
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
