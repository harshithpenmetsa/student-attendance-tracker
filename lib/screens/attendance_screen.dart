import 'package:flutter/material.dart';
import '../models/student.dart';

class AttendanceScreen extends StatefulWidget {
  final List<Student> students;

  const AttendanceScreen({super.key, required this.students});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final Map<int, bool> attendance = {};

  void markAttendance(Student student, bool isPresent) {
    setState(() {
      // If attendance was already marked today,
      // remove the previous count before adding the new one.
      if (attendance.containsKey(student.id)) {
        final previousStatus = attendance[student.id]!;

        if (previousStatus) {
          student.presentDays--;
        } else {
          student.absentDays--;
        }
      }

      attendance[student.id] = isPresent;

      if (isPresent) {
        student.presentDays++;
      } else {
        student.absentDays++;
      }
    });
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
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(student.rollNumber),

                              const SizedBox(height: 4),

                              Text(
                                status == null
                                    ? 'Not marked'
                                    : status
                                    ? 'Present'
                                    : 'Absent',
                              ),

                              const SizedBox(height: 4),

                              Text(
                                'Attendance: '
                                '${student.attendancePercentage.toStringAsFixed(1)}%',
                              ),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                markAttendance(student, true);
                              },
                              icon: const Icon(Icons.check),
                              tooltip: 'Present',
                            ),

                            IconButton(
                              onPressed: () {
                                markAttendance(student, false);
                              },
                              icon: const Icon(Icons.close),
                              tooltip: 'Absent',
                            ),
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
