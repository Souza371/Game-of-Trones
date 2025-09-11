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
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1a1a1a),
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.dark(
          primary: Color(0xFFC8A971), // dourado
          secondary: Color(0xFF8B0000), // vermelho escuro
          background: Color(0xFF1a1a1a),
          surface: Color(0xFF2c2c2c),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1a1a1a),
          foregroundColor: Color(0xFFC8A971),
          elevation: 8,
          titleTextStyle: TextStyle(
            fontFamily: 'MedievalSharp',
            fontSize: 26,
            color: Color(0xFFC8A971),
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.black54, offset: Offset(2,2), blurRadius: 4)],
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF2c2c2c),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xFFC8A971), width: 1.5),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC8A971),
            foregroundColor: Color(0xFF1a1a1a),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
        ),
        textTheme: ThemeData.dark().textTheme.copyWith(
          headlineLarge: const TextStyle(fontFamily: 'MedievalSharp', color: Color(0xFFC8A971)),
          headlineMedium: const TextStyle(fontFamily: 'MedievalSharp', color: Color(0xFFC8A971)),
          headlineSmall: const TextStyle(fontFamily: 'MedievalSharp', color: Color(0xFFC8A971)),
          titleLarge: const TextStyle(fontFamily: 'MedievalSharp', color: Color(0xFFC8A971)),
          titleMedium: const TextStyle(fontFamily: 'MedievalSharp', color: Color(0xFFC8A971)),
          titleSmall: const TextStyle(fontFamily: 'MedievalSharp', color: Color(0xFFC8A971)),
          bodyLarge: const TextStyle(fontFamily: 'Roboto', color: Color(0xFFF5F5F5)),
          bodyMedium: const TextStyle(fontFamily: 'Roboto', color: Color(0xFFF5F5F5)),
          bodySmall: const TextStyle(fontFamily: 'Roboto', color: Color(0xFFCCCCCC)),
        ),
        dataTableTheme: DataTableThemeData(
          headingRowColor: MaterialStateProperty.all(Color(0xFF8B0000)),
          headingTextStyle: const TextStyle(fontFamily: 'MedievalSharp', color: Color(0xFFF5F5F5), fontWeight: FontWeight.bold),
          dataRowColor: MaterialStateProperty.all(Color(0xFF2c2c2c)),
          dataTextStyle: const TextStyle(fontFamily: 'Roboto', color: Color(0xFFF5F5F5)),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF2c2c2c),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC8A971)),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC8A971), width: 2),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          labelStyle: TextStyle(color: Color(0xFFC8A971)),
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
