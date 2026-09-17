import 'package:flutter/material.dart';

class AttendanceCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const AttendanceCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          children: [
            Icon(icon, size: 32),

            const SizedBox(height: 10),

            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
