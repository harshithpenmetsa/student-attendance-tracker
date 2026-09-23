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
    final previousStatus = attendance[student.id];

    // Prevent duplicate marking.
    if (previousStatus == isPresent) {
      return;
    }

    setState(() {
      // If attendance was already marked,
      // remove the previous count first.
      if (previousStatus != null) {
        if (previousStatus) {
          student.presentDays--;
        } else {
          student.absentDays--;
        }
      }

      // Save the new attendance status.
      attendance[student.id] = isPresent;

      // Add the new count.
      if (isPresent) {
        student.presentDays++;
      } else {
        student.absentDays++;
      }
    });
  }

  String getStatusText(bool? status) {
    if (status == null) {
      return 'Not Marked';
    }

    return status ? 'Present' : 'Absent';
  }

  IconData getStatusIcon(bool? status) {
    if (status == null) {
      return Icons.help_outline;
    }

    return status ? Icons.check_circle : Icons.cancel;
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
                    padding: const EdgeInsets.all(14),

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

                                  Text(
                                    student.rollNumber,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),

                            _buildStatusBadge(status),
                          ],
                        ),

                        const SizedBox(height: 12),

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
                                onPressed: status == true
                                    ? null
                                    : () {
                                        markAttendance(student, true);
                                      },
                                icon: const Icon(Icons.check),
                                label: const Text('Present'),
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: status == false
                                    ? null
                                    : () {
                                        markAttendance(student, false);
                                      },
                                icon: const Icon(Icons.close),
                                label: const Text('Absent'),
                              ),
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

  Widget _buildStatusBadge(bool? status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(getStatusIcon(status), size: 18),

          const SizedBox(width: 5),

          Text(
            getStatusText(status),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
