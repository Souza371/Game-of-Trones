import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex Temática - Game of Thrones'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bem-vindo à Pokedex Temática!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Explore personagens, personalize seu perfil e escolha seu brasão.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: Text('Começar'),
            ),
          ],
        ),
      ),
    );
  }
}
