import 'package:flutter/material.dart';
import 'package:protasenko_kiyki_21_8/models/student.dart';
import 'package:protasenko_kiyki_21_8/widgets/students.dart';

void main() {
  runApp(const MaterialApp(
    home: StudentsScreen(
        students: [
          Student(
          firstName: 'Anna',
          lastName: 'Ivanova',
          department: Department.it,
          grade: 90,
          gender: Gender.female,
        ),
        Student(
          firstName: 'Ivan',
          lastName: 'Petrov',
          department: Department.law,
          grade: 85,
          gender: Gender.male,
        ),
        Student(
          firstName: 'Olga',
          lastName: 'Smirnova',
          department: Department.finance,
          grade: 92,
          gender: Gender.female,
        ),
        Student(
          firstName: 'Alexey',
          lastName: 'Kuznetsov',
          department: Department.medical,
          grade: 88,
          gender: Gender.male,
        ),
        Student(
          firstName: 'Elena',
          lastName: 'Popova',
          department: Department.law,
          grade: 87,
          gender: Gender.female,
        ),
        Student(
          firstName: 'Dmitry',
          lastName: 'Sokolov',
          department: Department.it,
          grade: 91,
          gender: Gender.male,
        ),
        ],
      ),
  ));
}
