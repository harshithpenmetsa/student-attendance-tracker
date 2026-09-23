import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentDetailsScreen extends StatelessWidget {
  final Student student;

  const StudentDetailsScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Details'), centerTitle: true),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            CircleAvatar(
              radius: 45,
              child: Text(
                student.name.isNotEmpty ? student.name[0].toUpperCase() : '?',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              student.name,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            Text(
              'Roll Number: ${student.rollNumber}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 30),

            _buildInfoCard(
              icon: Icons.calendar_month,
              title: 'Total Attendance Days',
              value: '${student.totalDays}',
            ),

            const SizedBox(height: 12),

            _buildInfoCard(
              icon: Icons.check_circle,
              title: 'Present Days',
              value: '${student.presentDays}',
            ),

            const SizedBox(height: 12),

            _buildInfoCard(
              icon: Icons.cancel,
              title: 'Absent Days',
              value: '${student.absentDays}',
            ),

            const SizedBox(height: 12),

            _buildInfoCard(
              icon: Icons.bar_chart,
              title: 'Attendance Percentage',
              value: '${student.attendancePercentage.toStringAsFixed(1)}%',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Icon(icon, size: 32),

            const SizedBox(width: 16),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
