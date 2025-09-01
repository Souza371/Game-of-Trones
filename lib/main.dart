import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/search_screen.dart';
import 'screens/character_detail_screen.dart';


void main() {
  runApp(GotPoquedexApp());
}

class GotPoquedexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex Temática - Game of Thrones',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Serif',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/search': (context) => SearchScreen(),
        // Para detalhes, use Navigator.push
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
