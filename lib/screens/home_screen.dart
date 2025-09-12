import 'package:flutter/material.dart';

import 'characters_screen.dart';
import 'martell_footer.dart';
import 'westeros_map_screen.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;
    final double baseFont = isMobile ? 16 : (size.width / 40).clamp(18, 32);
    final double titleFont = isMobile ? 24 : (size.width / 20).clamp(28, 48);
    final double buttonFont = isMobile ? 16 : (size.width / 36).clamp(18, 32);
    final double cardPadding = isMobile ? 12 : (size.width / 40).clamp(16, 32);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.all(isMobile ? 12 : 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Game of Thrones',
              style: TextStyle(
                fontFamily: 'Cinzel',
                fontSize: titleFont,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFD8A31A),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Bem-vindo ao reino de Westeros!',
              style: TextStyle(
                fontSize: baseFont,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: isMobile ? 1 : 3,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                childAspectRatio: isMobile ? 1.2 : 1.1,
                children: [
                  // Cards do menu
                  _MenuItem(
                    icon: '👑',
                    title: 'Personagens',
                    description:
                        'Explore os personagens mais importantes das Sete Casas de Westeros. Conheça suas histórias, alianças e batalhas.',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CharactersScreen()),
                    ),
                    compact: false,
                  ),
                  _MenuItem(
                    icon: '🗺️',
                    title: 'Mapa de Westeros',
                    description:
                        'Navegue pelo mapa interativo dos Sete Reinos. Descubra castelos, cidades e locais importantes.',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WesterosMapScreen()),
                    ),
                    compact: false,
                  ),
                  _MenuItem(
                    icon: '❓',
                    title: 'Quiz das Casas',
                    description:
                        'Teste seu conhecimento sobre as grandes casas de Westeros em nosso desafio de perguntas e respostas.',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QuizScreen()),
                    ),
                    compact: false,
                  ),
                ],
              ),
            ),
            // Rodapé estilizado Casa Martell
            const MartellFooter(compact: true),
          ],
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
  final bool compact;
  const _MenuItem(
      {required this.icon,
      required this.title,
      required this.description,
      required this.onTap,
      this.compact = false});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: compact ? 4 : 10.0),
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
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            vertical: compact ? 8 : (isMobile ? 14 : 18),
            horizontal: compact ? 8 : (isMobile ? 10 : 18),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: compact ? 32 : (isMobile ? 38 : 48),
                height: compact ? 32 : (isMobile ? 38 : 48),
                decoration: BoxDecoration(
                  color: const Color(0xFF2c2c2c),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color(0xFFbf9b30), width: 2),
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    right: compact ? 8 : (isMobile ? 10 : 16)),
                child: Text(
                  icon,
                  style: TextStyle(
                    fontSize: compact ? 16 : (isMobile ? 18 : 22),
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
                        fontSize: compact ? 13 : (isMobile ? 15 : 18),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: compact ? 2 : 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: compact ? 10 : (isMobile ? 11 : 13),
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
