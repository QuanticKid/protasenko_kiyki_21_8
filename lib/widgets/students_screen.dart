import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/students_provider.dart';
import 'student_item.dart';
import 'new_student.dart';
import '../models/student.dart';

class StudentsScreen extends ConsumerWidget {
  const StudentsScreen({super.key});

  void _showEditStudentModal(BuildContext context, WidgetRef ref, {required Student student}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return NewStudent(
          student: student,
          onSave: (updatedStudent) {
            ref.read(studentsProvider.notifier).editStudent(student, updatedStudent);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentsProvider);
    final notifier = ref.read(studentsProvider.notifier);

    return Scaffold(
      body: students.isEmpty
          ? const Center(child: Text('Empty.'))
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Dismissible(
                  key: ValueKey(student),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    notifier.deleteStudent(student);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${student.firstName} deleted.'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            notifier.restoreStudent();
                          },
                        ),
                      ),
                    );
                  },
                  child: InkWell(
                    onTap: () {
                      _showEditStudentModal(context, ref, student: student);
                    },
                    child: StudentItem(student: student),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => NewStudent(
            onSave: (newStudent) => notifier.addStudent(newStudent),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
