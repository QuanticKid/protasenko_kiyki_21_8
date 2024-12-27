import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/tabs_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.latoTextTheme().copyWith(
          titleLarge: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
          titleMedium: GoogleFonts.lato(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal,
          titleTextStyle: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
      ),
      home: const TabsScreen(),
    );
  }
}
