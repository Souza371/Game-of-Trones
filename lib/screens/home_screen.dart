import 'package:flutter/material.dart';

import 'characters_screen.dart';
import 'westeros_map_screen.dart';
import 'quiz_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Gradiente medieval
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0c0c0c), Color(0xFF1a1a1a)],
              ),
            ),
          ),
          // Overlay para efeito de textura
          Opacity(
            opacity: 0.12,
            child: Image.asset(
              'assets/images/castle_bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // Título estilizado
                  Text(
                    'Game of Thrones',
                    style: TextStyle(
                      fontFamily: 'MedievalSharp',
                      fontSize: isMobile ? 38 : 56,
                      color: const Color(0xFFbf9b30),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(color: Colors.black.withOpacity(0.7), offset: Offset(3,3), blurRadius: 6),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    height: 3,
                    width: isMobile ? 120 : 220,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Color(0xFFbf9b30), Colors.transparent],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'O reino de Westeros aguarda sua exploração',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      color: Color(0xFFA0A0A0),
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 36),
                  // Cards verticais
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _MenuItem(
                        icon: '👑',
                        title: 'Personagens',
                        description: 'Explore os personagens mais importantes das Sete Casas de Westeros. Conheça suas histórias, alianças e batalhas.',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CharactersScreen()),
                        ),
                      ),
                      _MenuItem(
                        icon: '🗺️',
                        title: 'Mapa de Westeros',
                        description: 'Navegue pelo mapa interativo dos Sete Reinos. Descubra castelos, cidades e locais importantes.',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const WesterosMapScreen()),
                        ),
                      ),
                      _MenuItem(
                        icon: '❓',
                        title: 'Quiz das Casas',
                        description: 'Teste seu conhecimento sobre as grandes casas de Westeros em nosso desafio de perguntas e respostas.',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const QuizScreen()),
                        ),
                      ),
                      _MenuItem(
                        icon: '📖',
                        title: 'História e Lore',
                        description: 'Mergulhe na rica história e mitologia do mundo de Game of Thrones. Aprenda sobre eventos passados que moldaram o presente.',
                        onTap: () {}, // Futuro: tela de lore
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // Footer
                  const Text(
                    '© 2023 Game of Thrones - Sistema de Informações. Todos os direitos reservados.\nEste é um projeto não oficial para fins educacionais.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF888888),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  const _MenuItem({required this.icon, required this.title, required this.description, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1e1e1e), Color(0xFF252525)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: const Color(0xFFbf9b30), width: 1.2),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 18 : 24,
            horizontal: isMobile ? 12 : 24,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: isMobile ? 48 : 60,
                height: isMobile ? 48 : 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF2c2c2c),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color(0xFFbf9b30), width: 2),
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: isMobile ? 12 : 20),
                child: Text(
                  icon,
                  style: TextStyle(
                    fontSize: isMobile ? 22 : 28,
                    color: const Color(0xFFbf9b30),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'MedievalSharp',
                        fontSize: isMobile ? 18 : 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: isMobile ? 13 : 15,
                        color: const Color(0xFFA0A0A0),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
