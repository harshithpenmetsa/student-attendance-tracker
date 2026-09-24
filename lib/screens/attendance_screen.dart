import 'package:flutter/material.dart';

import '../models/student.dart';
import '../services/storage_service.dart';

class AttendanceScreen extends StatefulWidget {
  final List<Student> students;

  const AttendanceScreen({super.key, required this.students});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final Map<int, bool> attendance = {};

  Future<void> markAttendance(Student student, bool isPresent) async {
    final previousStatus = attendance[student.id];

    // Prevent duplicate attendance.
    if (previousStatus == isPresent) {
      return;
    }

    setState(() {
      // Remove the previous attendance count.
      if (previousStatus != null) {
        if (previousStatus) {
          student.presentDays--;
        } else {
          student.absentDays--;
        }
      }

      // Store the new status.
      attendance[student.id] = isPresent;

      // Add the new attendance count.
      if (isPresent) {
        student.presentDays++;
      } else {
        student.absentDays++;
      }
    });

    // Save immediately after attendance changes.
    await StorageService.saveStudents(widget.students);
  }

  String getStatus(Student student) {
    final status = attendance[student.id];

    if (status == null) {
      return 'Not Marked';
    }

    return status ? 'Present' : 'Absent';
  }

  Color getStatusColor(Student student) {
    final status = attendance[student.id];

    if (status == null) {
      return Colors.grey;
    }

    return status ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mark Attendance'), centerTitle: true),

      body: widget.students.isEmpty
          ? const Center(
              child: Text(
                'No students available.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.students.length,
              itemBuilder: (context, index) {
                final student = widget.students[index];

                final status = attendance[student.id];

                return Card(
                  margin: const EdgeInsets.only(bottom: 14),
                  child: Padding(
                    padding: const EdgeInsets.all(16),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(child: Text('${index + 1}')),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    student.name,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text('Roll Number: ${student.rollNumber}'),
                                ],
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: getStatusColor(
                                  student,
                                ).withValues(alpha: 0.12),
                              ),
                              child: Text(
                                getStatus(student),
                                style: TextStyle(
                                  color: getStatusColor(student),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        Text(
                          'Attendance: '
                          '${student.attendancePercentage.toStringAsFixed(1)}%',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  markAttendance(student, true);
                                },
                                icon: const Icon(Icons.check),
                                label: const Text('Present'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: status == true
                                      ? Colors.green
                                      : null,
                                  foregroundColor: status == true
                                      ? Colors.white
                                      : null,
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  markAttendance(student, false);
                                },
                                icon: const Icon(Icons.close),
                                label: const Text('Absent'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: status == false
                                      ? Colors.red
                                      : null,
                                  foregroundColor: status == false
                                      ? Colors.white
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Present: ${student.presentDays}'),

                            Text('Absent: ${student.absentDays}'),

                            Text('Total: ${student.totalDays}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
