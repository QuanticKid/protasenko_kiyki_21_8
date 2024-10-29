import 'package:flutter/material.dart';
import 'package:protasenko_kiyki_21_8/models/student.dart';
import 'package:protasenko_kiyki_21_8/widgets/student_item.dart';

class StudentsScreen extends StatelessWidget {

  final List<Student> students;

  const StudentsScreen({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return StudentItem(student: students[index]);
        },
      ),
    );
  }
}
