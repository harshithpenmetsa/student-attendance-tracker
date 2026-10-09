# Student Attendance Tracker

A Flutter-based student attendance management application that helps users manage students, mark attendance, and track attendance statistics.

## About the Project

Student Attendance Tracker is a simple Flutter application designed to make student attendance management easier.

The application allows users to add students, edit student information, delete students, mark attendance, and view individual attendance details. Student and attendance data are stored locally so that the data remains available after restarting the application.

## Features

- Add students
- Edit student information
- Delete students
- View student details
- Mark students as Present
- Mark students as Absent
- Calculate attendance percentage
- View overall attendance statistics
- Store student data locally
- Restore data after application restart
- Prevent duplicate attendance counting
- Clean and responsive user interface

## Technologies Used

- Flutter
- Dart
- Material Design
- SharedPreferences
- Git
- GitHub
- Visual Studio Code

## Project Structure

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


## Project Implementation

<img width="396" height="766" alt="image" src="https://github.com/user-attachments/assets/8d57680f-b745-44d8-aad5-cede510d8141" />


### Student Model

The `Student` class is used to store the details of each student in the application. It contains the student's ID, name, roll number, present days and absent days.

It also calculates the total number of attendance days and the attendance percentage. The `toMap()` and `fromMap()` methods are used to convert the student data so that it can be saved and loaded from local storage.
