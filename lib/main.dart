import 'package:companion/HomeScreen/activity_model.dart';
import 'package:companion/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ActivityModel(),
      child: const CompaniONApp(),
    ),
  );
}

class CompaniONApp extends StatelessWidget {
  const CompaniONApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Onboarding(),
    );
  }
}