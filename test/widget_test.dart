import 'package:flutter_test/flutter_test.dart';

import 'package:student_attendance_tracker/main.dart';

void main() {
  testWidgets('Student Attendance Tracker loads', (WidgetTester tester) async {
    await tester.pumpWidget(const StudentAttendanceTracker());

    expect(find.text('Attendance Tracker'), findsOneWidget);
  });
}
