import 'package:flutter/material.dart';
import 'departments_screen.dart';
import 'students_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedTabIndex = 0;

  final List<Widget> _pages = [
    const DepartmentsScreen(),
    const StudentsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedTabIndex == 0 ? 'Departments' : 'Students'),
      ),
      body: _pages[_selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: (index) => setState(() => _selectedTabIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Departments'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Students'),
        ],
      ),
    );
  }
}
