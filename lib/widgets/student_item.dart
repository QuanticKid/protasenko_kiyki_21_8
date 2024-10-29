import 'package:flutter/material.dart';
import 'package:protasenko_kiyki_21_8/models/student.dart';

class StudentItem extends StatelessWidget {
  final Student student;
  const StudentItem({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = student.gender == Gender.male
        ? Colors.blue[100]!
        : Colors.pink[100]!;

    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '${student.firstName} ${student.lastName}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              departmentIcons[student.department],
              size: 24,
              color: Colors.blueGrey,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                student.grade.toString(),
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
