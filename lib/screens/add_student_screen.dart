import 'package:flutter/material.dart';
import '../models/student.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rollNumberController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    rollNumberController.dispose();
    super.dispose();
  }

  void saveStudent() {
    final name = nameController.text.trim();
    final rollNumber = rollNumberController.text.trim();

    if (name.isEmpty || rollNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter student name and roll number'),
        ),
      );
      return;
    }

    final student = Student(
      id: DateTime.now().millisecondsSinceEpoch,
      name: name,
      rollNumber: rollNumber,
    );

    Navigator.pop(context, student);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Student'), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Student Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Student Name',
                hintText: 'Enter student name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: rollNumberController,
              decoration: const InputDecoration(
                labelText: 'Roll Number',
                hintText: 'Enter roll number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: saveStudent,
                icon: const Icon(Icons.save),
                label: const Text('Add Student'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
