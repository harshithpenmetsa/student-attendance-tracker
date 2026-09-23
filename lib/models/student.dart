class Student {
  final int id;
  String name;
  String rollNumber;

  int presentDays;
  int absentDays;

  Student({
    required this.id,
    required this.name,
    required this.rollNumber,
    this.presentDays = 0,
    this.absentDays = 0,
  });

  int get totalDays => presentDays + absentDays;

  double get attendancePercentage {
    if (totalDays == 0) {
      return 0;
    }

    return (presentDays / totalDays) * 100;
  }
}
