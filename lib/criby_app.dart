import 'package:criby_payment/presentation/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class CribyApp extends StatelessWidget {
  const CribyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistrationScreen(),

      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,

        inputDecorationTheme: textFormFieldDecoration(),
      ),
    );
  }

  Widget textFormFieldDecoration() {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0x330C0310), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue, width: 2.0),
      ),
    );
  }
}
