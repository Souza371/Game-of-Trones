import 'package:flutter/material.dart';
import 'characters_screen.dart';
import 'martell_footer.dart';
import 'westeros_map_screen.dart';
import 'quiz_screen.dart';
// Imagem de fundo do castelo
const String castleBg = 'assets/images/castle_bg.jpg';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;
    final double baseFont = isMobile ? 16 : (size.width / 40).clamp(18, 32);
    final double titleFont = isMobile ? 24 : (size.width / 20).clamp(28, 48);
  // final double buttonFont = isMobile ? 16 : (size.width / 36).clamp(18, 32);
  // final double cardPadding = isMobile ? 12 : (size.width / 40).clamp(16, 32);
    return Scaffold(
      extendBodyBehindAppBar: true,

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
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6B4F3A), // marrom semelhante ao quiz
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
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
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Cinzel',
                  shadows: [Shadow(blurRadius: 6, color: Colors.black45, offset: Offset(0, 2))],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
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
