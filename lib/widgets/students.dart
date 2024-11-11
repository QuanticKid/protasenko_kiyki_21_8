import 'package:flutter/material.dart';
import 'package:protasenko_kiyki_21_8/models/student.dart';
import 'package:protasenko_kiyki_21_8/widgets/student_item.dart';
import 'package:protasenko_kiyki_21_8/widgets/new_student.dart';

class StudentsScreen extends StatefulWidget {
  final List<Student> students;

  const StudentsScreen({super.key, required this.students});

  @override
  _StudentsScreenState createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  late List<Student> studentsList;

  @override
  void initState() {
    super.initState();
    studentsList = List<Student>.from(widget.students);
  }

  void _addStudent(Student student) {
    setState(() => studentsList.add(student));
  }

  void _editStudent(int index, Student updatedStudent) {
    setState(() => studentsList[index] = updatedStudent);
  }

  void _showAddEditStudentDialog({Student? student, int? index}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: NewStudent(
          student: student,
          onSave: (newStudent) {
            if (student == null) {
              _addStudent(newStudent);
            } else {
              _editStudent(index!, newStudent);
            }
          },
        ),
      );
    },
  );
}

  void _deleteStudent(int index) {
    final deletedStudent = studentsList[index];
    setState(() => studentsList.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Student deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() => studentsList.insert(index, deletedStudent));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddEditStudentDialog(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: studentsList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(studentsList[index]),
            background: Container(color: Colors.red),
            onDismissed: (_) => _deleteStudent(index),
            child: InkWell(
              onTap: () => _showAddEditStudentDialog(
                student: studentsList[index],
                index: index,
              ),
              child: StudentItem(student: studentsList[index]),
            ),
          );
        },
      ),
    );
  }
}
