import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/search_screen.dart';
import 'screens/character_detail_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/emblem_creator_screen.dart';
import 'screens/quiz_result_screen.dart';
import 'screens/house_result_screen.dart';


void main() {
  runApp(GotPoquedexApp());
}

class GotPoquedexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex Temática - Game of Thrones',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF222831),
          secondary: Color(0xFFD8A31A),
        ),
        scaffoldBackgroundColor: Color(0xFF1B1B1B),
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Cinzel',
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF222831),
          foregroundColor: Color(0xFFD8A31A),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFD8A31A),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/search': (context) => SearchScreen(),
        '/quiz': (context) => QuizScreen(),
        '/emblem': (context) => EmblemCreatorScreen(),
  '/result': (context) => QuizResultScreen(),
  '/house_result': (context) => HouseResultScreen(),
        // Para detalhes, use Navigator.push
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
