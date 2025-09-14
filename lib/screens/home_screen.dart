import 'package:flutter/material.dart';
import 'characters_screen.dart';
import 'westeros_map_screen.dart';
import 'quiz_screen.dart';
import 'martell_footer.dart';
// Imagem de fundo do castelo
const String castleBg = 'assets/images/castle_bg.jpg';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 2, top: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Game of',
                style: TextStyle(
                  fontFamily: 'Cinzel',
                  fontSize: 26,
                  color: const Color(0xFFFFD700),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.2,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.8),
                      offset: const Offset(2, 2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Thrones',
                style: TextStyle(
                  fontFamily: 'Cinzel',
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.5,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.9),
                      offset: const Offset(2, 3),
                      blurRadius: 10,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(castleBg),
            fit: BoxFit.cover,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 700;
            return Center(
              child: SizedBox(
                width: isMobile ? double.infinity : 340,
                height: constraints.maxHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Bloco de botões estilizado
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.50),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Color(0xFFFFD700), width: 1.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.18),
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _MenuItem(
                            icon: '🗺️',
                            title: 'Mapa de Westeros',
                            description: 'Explore o mapa do mundo de Game of Thrones',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => WesterosMapScreen()),
                              );
                            },
                          ),
                          const SizedBox(height: 4),
                          _MenuItem(
                            icon: '👑',
                            title: 'Personagens',
                            description: 'Veja os personagens principais',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CharactersScreen()),
                              );
                            },
                          ),
                          const SizedBox(height: 4),
                          _MenuItem(
                            icon: '❓',
                            title: 'Quiz',
                            description: 'Teste seus conhecimentos',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => QuizScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: MartellFooter(
                        compact: true,
                        showCredit: true,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  const _MenuItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6B4F3A),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 2,
          ),
          onPressed: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$icon  $title',
                style: TextStyle(
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Cinzel',
                  shadows: [Shadow(blurRadius: 6, color: Colors.black45, offset: Offset(0, 2))],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: isMobile ? 12 : 14,
                  color: Colors.white,
                  fontFamily: 'MedievalSharp',
                  shadows: [Shadow(blurRadius: 4, color: Colors.black38, offset: Offset(0, 1))],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
