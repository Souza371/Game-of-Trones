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
            ElevatedButton.icon(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              label: Text('Perfil'),
              style: ElevatedButton.styleFrom(minimumSize: Size(200, 40)),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
              label: Text('Buscar Personagens'),
              style: ElevatedButton.styleFrom(minimumSize: Size(200, 40)),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.shield),
              onPressed: () {
                Navigator.pushNamed(context, '/emblem');
              },
              label: Text('Criar Brasão'),
              style: ElevatedButton.styleFrom(minimumSize: Size(200, 40)),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.quiz),
              onPressed: () {
                Navigator.pushNamed(context, '/quiz');
              },
              label: Text('Quiz das Casas'),
              style: ElevatedButton.styleFrom(minimumSize: Size(200, 40)),
            ),
          ],
        ),
      ),
    );
  }
}
