import 'package:flutter/material.dart';
import 'package:small_project/home/DiagnosisForm.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
   home: DiagnosisForm(),
    );
  }
}
