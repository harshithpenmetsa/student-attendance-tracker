import 'package:flutter/material.dart';
import '../models/student.dart';
import '../widgets/attendance_card.dart';
import 'student_list_screen.dart';
import 'attendance_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Student> students = [];

  Future<void> openStudentList() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentListScreen(students: students),
      ),
    );

    setState(() {});
  }

  void openAttendanceScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AttendanceScreen(students: students),
      ),
    ).then((_) {
      setState(() {});
    });
  }

  int get presentToday {
    int count = 0;

    for (final student in students) {
      if (student.presentDays > 0) {
        count++;
      }
    }

    return count;
  }

  int get absentToday {
    int count = 0;

    for (final student in students) {
      if (student.absentDays > 0) {
        count++;
      }
    }

    return count;
  }

  double get overallAttendance {
    int totalPresent = 0;
    int totalDays = 0;

    for (final student in students) {
      totalPresent += student.presentDays;
      totalDays += student.totalDays;
    }

    if (totalDays == 0) {
      return 0;
    }

    return (totalPresent / totalDays) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Tracker'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome 👋',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              'Track your class attendance easily.',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: AttendanceCard(
                    title: 'Total Students',
                    value: '${students.length}',
                    icon: Icons.people,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: AttendanceCard(
                    title: 'Present Today',
                    value: '$presentToday',
                    icon: Icons.check_circle,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: AttendanceCard(
                    title: 'Absent Today',
                    value: '$absentToday',
                    icon: Icons.cancel,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: AttendanceCard(
                    title: 'Attendance',
                    value: '${overallAttendance.toStringAsFixed(1)}%',
                    icon: Icons.bar_chart,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: openStudentList,
                icon: const Icon(Icons.person_add),
                label: const Text('Add Student'),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: openAttendanceScreen,
                icon: const Icon(Icons.fact_check),
                label: const Text('Mark Attendance'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
