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
```
## Project Implementation

### Student Model

The `Student` class is used to store the details of each student in the application. It contains the student's ID, name, roll number, present days and absent days.

It also calculates the total number of attendance days and the attendance percentage. The `toMap()` and `fromMap()` methods are used to convert the student data so that it can be saved and loaded from local storage.

#### Source Code

<img width="377" height="756" alt="image" src="https://github.com/user-attachments/assets/6919af25-a054-4b8d-86bd-f325bc090423" />

### Storage Service

The `StorageService` is used to save and load student data locally using `SharedPreferences`.

The `saveStudents()` function converts the student list into a format that can be stored and saves it locally. The `loadStudents()` function reads the saved data and converts it back into `Student` objects.

This helps the application keep the student data even after the app is closed and opened again.

#### Source Code

<img width="626" height="661" alt="image" src="https://github.com/user-attachments/assets/a9d77fc3-490b-4c60-a009-6bea6551b05b" />

### Attendance Card

`AttendanceCard` is a custom reusable widget used to display attendance information in the application.

It takes a title, value and icon as input and displays them inside a card. I used this widget so that the same attendance card design can be reused with different information.

The widget is a `StatelessWidget` because its UI only depends on the values passed to it.

#### Source Code

<img width="645" height="796" alt="image" src="https://github.com/user-attachments/assets/54ed7bde-91b4-44b5-9436-a31448bc7bdc" />

### Home Screen

The `HomeScreen` is the main screen of the application. It loads the saved student data when the screen starts and updates the UI using `setState()`.

It also provides navigation to the student list and attendance screens using `Navigator.push()`.

#### State Management and Data Loading

The screen uses a `StatefulWidget` because the student data and loading status can change while the application is running.

<img width="510" height="520" alt="image" src="https://github.com/user-attachments/assets/cee0192f-8b16-40d5-89d2-e4e61f76e283" />

#### Navigation

The home screen uses `Navigator.push()` and `MaterialPageRoute` to move to the Student List and Attendance screens.

<img width="531" height="498" alt="image" src="https://github.com/user-attachments/assets/b29ff26d-dcf9-4839-8ca1-25ba5a14bb90" />

### Student List Screen

The Student List screen is used to display and manage the students added to the application.

#### Adding a Student

The `openAddStudentScreen()` function opens the Add Student screen using navigation. After a new student is added, the student is added to the list and the updated data is saved locally.

<img width="531" height="283" alt="image" src="https://github.com/user-attachments/assets/74793dc8-e350-4db5-98a3-03fdee5a7899" />

#### Deleting a Student

The `deleteStudent()` function is used to remove a student from the list. Before deleting, the application shows a confirmation dialog. After deletion, the list is updated and the data is saved again.

<img width="522" height="492" alt="image" src="https://github.com/user-attachments/assets/59fca600-bb5f-46fb-8b97-ecdadb68b0a1" />

### Add Student Screen

The Add Student screen is used to add a new student or edit an existing student's details.

It uses `TextEditingController` to read the student name and roll number. The same screen is also used for editing by loading the existing student's details when needed.

#### Student Input

The screen uses text controllers and `initState()` to handle student information.

<img width="622" height="275" alt="image" src="https://github.com/user-attachments/assets/c7994fa8-bcf4-4428-824b-913177e4419f" />

#### Saving Student Data

The `saveStudent()` function checks the entered details, creates a new `Student` or updates an existing one, and returns the data to the previous screen using `Navigator.pop()`.

<img width="582" height="235" alt="image" src="https://github.com/user-attachments/assets/8fbc48c2-cf33-459c-9e06-dfe467b3f466" />

### Student Details Screen

The Student Details screen displays the selected student's information along with their attendance details.

It shows the student's name, roll number, total attendance days, present days, absent days and attendance percentage.

#### Student Details UI

The screen displays the student information and attendance statistics using Flutter widgets such as `CircleAvatar`, `Text` and `Card`.

<img width="582" height="330" alt="image" src="https://github.com/user-attachments/assets/71b927f5-58af-4054-b310-01b9ca33b5ef" />

#### Reusable Information Card

The `_buildInfoCard()` function is used to create the attendance information cards. Instead of writing the same Card layout multiple times, the function accepts an icon, title and value and creates the card.

<img width="625" height="663" alt="image" src="https://github.com/user-attachments/assets/a6cc4706-c1ff-41c3-92a7-20fbf5c392ba" />

### Attendance Screen

The Attendance screen is used to mark students as present or absent.

The screen keeps track of the attendance status for each student and updates their present and absent counts. The updated data is also saved locally after attendance is changed.

#### Attendance Logic

The `markAttendance()` function handles marking students as present or absent. It also prevents duplicate attendance from being counted and updates the student data using `setState()`.

<img width="605" height="575" alt="image" src="https://github.com/user-attachments/assets/97643218-e519-46e3-8613-7f8d6e1f6eb8" />

### Main Application

The `main.dart` file is the starting point of the application. It creates the `MaterialApp`, sets the application theme and opens the `HomeScreen` as the first screen.

<img width="563" height="362" alt="image" src="https://github.com/user-attachments/assets/782228ff-4424-4f2a-adfc-3766a32f4454" />

