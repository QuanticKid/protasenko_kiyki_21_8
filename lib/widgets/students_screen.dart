import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/students_provider.dart';
import 'student_item.dart';
import 'new_student.dart';
import '../models/student.dart';

class StudentsScreen extends ConsumerWidget {
  const StudentsScreen({super.key});

  void _showEditStudentModal(BuildContext context, WidgetRef ref, {int? index}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return NewStudent(studentIndex: index);
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsState = ref.watch(studentsProvider);
    final notifier = ref.read(studentsProvider.notifier);

    return Scaffold(
      body: () {
        if (studentsState.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (studentsState.students.isEmpty) {
          return const Center(
            child: Text("Empty."),
          );
        } else {
          return ListView.builder(
              itemCount: studentsState.students.length,
              itemBuilder: (context, index) {
                final student = studentsState.students[index];
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
                    notifier.deleteStudent(index);

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
                    ).closed.then((value) {
                      if (value != SnackBarClosedReason.action) {
                        ref.read(studentsProvider.notifier).removeInstant();
                      }
                    });
                  },
                  child: InkWell(
                    onTap: () {
                      _showEditStudentModal(context, ref, index: index);
                    },
                    child: StudentItem(student: student),
                  ),
                );
              },
            );
        
      }
      }(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => NewStudent(),
        ),
        child: const Icon(Icons.add),
      )
    );
  }
}
