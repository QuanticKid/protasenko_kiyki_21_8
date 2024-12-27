import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/department.dart';
import '../providers/students_provider.dart';

class DepartmentsScreen extends ConsumerWidget {
  const DepartmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentsProvider);
    final departmentCounts = {
      for (var department in Department.values)
        department: students.where((student) => student.department == department).length,
    };

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: Department.values.length,
      itemBuilder: (context, index) {
        final department = Department.values[index];
        return Card(
          color: Colors.blue.shade100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(departmentIcons[department], size: 48, color: Colors.blue.shade900),
              Text(
                departmentNames[department]!,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('${departmentCounts[department]} students'),
            ],
          ),
        );
      },
    );
  }
}
