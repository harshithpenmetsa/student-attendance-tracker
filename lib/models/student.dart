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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rollNumber': rollNumber,
      'presentDays': presentDays,
      'absentDays': absentDays,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      rollNumber: map['rollNumber'],
      presentDays: map['presentDays'] ?? 0,
      absentDays: map['absentDays'] ?? 0,
    );
  }
}
