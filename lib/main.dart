import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perp_clone/pages/home_page.dart';
import 'package:perp_clone/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Professor Perpy',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.submitButton),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme.copyWith(
            bodyMedium: const TextStyle(
              fontSize: 15,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
