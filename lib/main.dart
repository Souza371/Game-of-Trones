import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game of Thrones',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        useMaterial3: true,
        fontFamily: 'MedievalSharp',
        textTheme: ThemeData.light().textTheme.copyWith(
          headlineLarge: const TextStyle(fontFamily: 'MedievalSharp'),
          headlineMedium: const TextStyle(fontFamily: 'MedievalSharp'),
          headlineSmall: const TextStyle(fontFamily: 'MedievalSharp'),
          titleLarge: const TextStyle(fontFamily: 'MedievalSharp'),
          titleMedium: const TextStyle(fontFamily: 'MedievalSharp'),
          titleSmall: const TextStyle(fontFamily: 'MedievalSharp'),
        ),
      ),
      home: const HomeScreen(), // VOLTA PARA A TELA INICIAL
      debugShowCheckedModeBanner: false,
    );
  }
}
