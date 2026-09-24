# Student Attendance Tracker

A Flutter-based student attendance management application that helps users manage students, mark attendance, and track attendance statistics.

## 📌 About the Project

Student Attendance Tracker is a simple Flutter application designed to make student attendance management easier.

The application allows users to add students, edit student information, delete students, mark attendance, and view individual attendance details. Student and attendance data are stored locally so that the data remains available after restarting the application.

## ✨ Features

- 👨‍🎓 Add students
- ✏️ Edit student information
- 🗑️ Delete students
- 👤 View student details
- ✅ Mark students as Present
- ❌ Mark students as Absent
- 📊 Calculate attendance percentage
- 📈 View overall attendance statistics
- 💾 Store student data locally
- 🔄 Restore data after application restart
- 🚫 Prevent duplicate attendance counting
- 📱 Clean and responsive user interface

## 🛠️ Technologies Used

- Flutter
- Dart
- Material Design
- SharedPreferences
- Git
- GitHub
- Visual Studio Code

## 📂 Project Structure

```text
lib/
│
├── main.dart
│
├── models/
│   └── student.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── student_list_screen.dart
│   ├── add_student_screen.dart
│   ├── student_details_screen.dart
│   └── attendance_screen.dart
│
├── services/
│   └── storage_service.dart
│
└── widgets/
    └── attendance_card.dart