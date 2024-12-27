import 'package:flutter/material.dart';
import 'package:protasenko_kiyki_21_8/models/student.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/students_provider.dart';
import '../models/department.dart';

class NewStudent extends ConsumerStatefulWidget {
  const NewStudent({
    super.key,
    this.studentIndex
  });

  final int? studentIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewStudentState();
}

class _NewStudentState extends ConsumerState<NewStudent> {
  late TextEditingController firstNameController = TextEditingController();
  late TextEditingController lastNameController = TextEditingController();
  late TextEditingController gradeController = TextEditingController();
  Department? selectedDepartment;
  Gender? selectedGender;

  @override
  void initState() {
    super.initState();
    if (widget.studentIndex != null) {
      final student = ref.read(studentsProvider).students[widget.studentIndex!];
      firstNameController.text = student.firstName;
      lastNameController.text = student.lastName;
      gradeController.text = student.grade.toString();
      selectedGender = student.gender;
      selectedDepartment = student.department;
    }
  }

  void enterStudent() async {
     final grade = int.tryParse(gradeController.text);

    if (grade == null || selectedDepartment == null || selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (widget.studentIndex != null) {
      await ref.read(studentsProvider.notifier).editStudent(
            widget.studentIndex!,
            firstNameController.text.trim(),
            lastNameController.text.trim(),
            selectedDepartment,
            selectedGender,
            grade,
          );
    } else {
      await ref.read(studentsProvider.notifier).addStudent(
            firstNameController.text.trim(),
            lastNameController.text.trim(),
            selectedDepartment,
            selectedGender,
            grade,
          );
    }

    if (!context.mounted) return;

    Navigator.of(context).pop(); 
  }

  @override
  Widget build(BuildContext context) {
    final studentsState = ref.watch(studentsProvider);

    Widget newStudentScreen = Padding(
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
            hint: const Text('Select Department'),
            items: Department.values.map((department) {
              return DropdownMenuItem(
                value: department,
                child: Row(
                  children: [
                    Icon(
                      departmentIcons[department],
                      color: Colors.blueGrey,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(departmentNames[department]!),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) => setState(() => selectedDepartment = value),
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
            onPressed: enterStudent,
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if(studentsState.isLoading) {
      newStudentScreen = const Center(
        child: CircularProgressIndicator(),
      );
    }
    return newStudentScreen; 
  }
}
