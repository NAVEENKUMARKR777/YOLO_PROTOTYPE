import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/auth/splash_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: YoloNeedApp(),
    ),
  );
}

class YoloNeedApp extends StatelessWidget {
  const YoloNeedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YOLO Need App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
} 