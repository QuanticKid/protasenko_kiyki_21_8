import 'package:flutter/material.dart';

enum Department { economy, law, engineering, medicine }

final Map<Department, IconData> departmentIcons = {
  Department.economy: Icons.monetization_on,
  Department.law: Icons.gavel,
  Department.engineering: Icons.build,
  Department.medicine: Icons.local_hospital,
};

final Map<Department, String> departmentNames = {
  Department.economy: 'Economy',
  Department.law: 'Law',
  Department.engineering: 'Engineering',
  Department.medicine: 'Medicine',
};
