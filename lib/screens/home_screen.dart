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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 36,
        automaticallyImplyLeading: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 700;
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(castleBg),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                // Título estilizado medieval unificado
                const SizedBox(height: 40),
                Text(
                  'Game of Thrones',
                  style: TextStyle(
                    fontFamily: 'MedievalSharp',
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFD700),
                    letterSpacing: 3,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.85),
                        offset: Offset(3, 3),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: SizedBox(
                                  width: isMobile ? 320 : 400,
                                  child: _MenuItem(
                                    icon: '🗺️',
                                    title: 'Mapa de Westeros',
                                    description: 'Explore o mapa do mundo de Game of Thrones',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => WesterosMapScreen()),
                                      );
                                    },
                                    small: true,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: SizedBox(
                                  width: isMobile ? 320 : 400,
                                  child: _MenuItem(
                                    icon: '👑',
                                    title: 'Personagens',
                                    description: 'Veja os personagens principais',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => CharactersScreen()),
                                      );
                                    },
                                    small: true,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: SizedBox(
                                  width: isMobile ? 320 : 400,
                                  child: _MenuItem(
                                    icon: '❓',
                                    title: 'Quiz',
                                    description: 'Teste seus conhecimentos',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => QuizScreen()),
                                      );
                                    },
                                    small: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Rodapé sempre na base
                MartellFooter(
                  compact: false,
                  showCredit: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  final bool small;
  const _MenuItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    this.small = false,
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
            padding: EdgeInsets.symmetric(
              vertical: small ? 10 : 14,
              horizontal: small ? 6 : 10,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 1,
            // Sem borda, sem sombra extra
          ),
          onPressed: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$icon  $title',
                style: TextStyle(
                  fontSize: small ? (isMobile ? 15 : 17) : (isMobile ? 18 : 20),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Cinzel',
                  // Sem sombra
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontSize: small ? (isMobile ? 10 : 12) : (isMobile ? 12 : 14),
                  color: Colors.white,
                  fontFamily: 'MedievalSharp',
                  // Sem sombra
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
