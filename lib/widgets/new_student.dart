import 'package:flutter/material.dart';
import 'package:protasenko_kiyki_21_8/models/student.dart';

class NewStudent extends StatefulWidget {
  final Student? student;
  final Function(Student) onSave;

  const NewStudent({Key? key, this.student, required this.onSave}) : super(key: key);

  @override
  _NewStudentState createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController gradeController;
  Department? selectedDepartment;
  Gender? selectedGender;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.student?.firstName);
    lastNameController = TextEditingController(text: widget.student?.lastName);
    gradeController = TextEditingController(text: widget.student?.grade.toString());
    selectedDepartment = widget.student?.department;
    selectedGender = widget.student?.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: firstNameController,
            decoration: const InputDecoration(labelText: 'First Name'),
          ),
          TextField(
            controller: lastNameController,
            decoration: const InputDecoration(labelText: 'Last Name'),
          ),
          TextField(
            controller: gradeController,
            decoration: const InputDecoration(labelText: 'Grade'),
            keyboardType: TextInputType.number,
          ),
          DropdownButton<Department>(
            value: selectedDepartment,
            onChanged: (value) => setState(() => selectedDepartment = value),
            items: Department.values.map((department) {
              return DropdownMenuItem(
                value: department,
                child: Text(department.toString().split('.').last),
              );
            }).toList(),
          ),
          DropdownButton<Gender>(
            value: selectedGender,
            onChanged: (value) => setState(() => selectedGender = value),
            items: Gender.values.map((gender) {
              return DropdownMenuItem(
                value: gender,
                child: Text(gender.toString().split('.').last),
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: () {
              final student = Student(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                grade: int.tryParse(gradeController.text) ?? 0,
                department: selectedDepartment!,
                gender: selectedGender!,
              );
              widget.onSave(student);
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
