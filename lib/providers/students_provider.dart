import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';

class StudentsNotifier extends StateNotifier<List<Student>> {
  StudentsNotifier() : super([]);

  Student? _recentlyDeletedStudent;
  int? _recentlyDeletedIndex;

  void addStudent(Student student) => state = [...state, student];

  void editStudent(Student oldStudent, Student updatedStudent) {
    state = [
      for (final student in state)
        if (student == oldStudent) updatedStudent else student,
    ];
  }

  void deleteStudent(Student student) {
    _recentlyDeletedIndex = state.indexOf(student);
    if (_recentlyDeletedIndex != -1) {
      _recentlyDeletedStudent = student;
      state = state.where((s) => s != student).toList();
    }
  }

  void restoreStudent() {
    if (_recentlyDeletedStudent != null && _recentlyDeletedIndex != null) {
      final updatedState = List<Student>.from(state);
      updatedState.insert(_recentlyDeletedIndex!, _recentlyDeletedStudent!);
      state = updatedState;

      _recentlyDeletedStudent = null;
      _recentlyDeletedIndex = null;
    }
  }

  
}

final studentsProvider = StateNotifierProvider<StudentsNotifier, List<Student>>(
  (ref) => StudentsNotifier(),
);
