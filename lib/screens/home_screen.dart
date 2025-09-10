import 'package:flutter/material.dart';
import 'characters_screen.dart';
import 'westeros_map_screen.dart';
import 'quiz_screen.dart';
// Remova as importa��es que n�o existem ou comente-as

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game of Thrones'),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/castle_bg.jpg',
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.25),
            colorBlendMode: BlendMode.darken,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.2,
              ),
              children: [
                _buildMenuCard(
                  context,
                  '👑 Personagens',
                  Icons.people,
                  Colors.blue,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CharactersScreen()),
                  ),
                ),
                _buildMenuCard(
                  context,
                  '🗺️ Mapa de Westeros',
                  Icons.map,
                  Colors.brown,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WesterosMapScreen()),
                  ),
                ),
                _buildMenuCard(
                  context,
                  '❓ Quiz das Casas',
                  Icons.quiz,
                  Colors.green,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizScreen()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 8,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
