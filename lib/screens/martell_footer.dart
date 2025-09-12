import 'package:flutter/material.dart';

class MartellFooter extends StatelessWidget {
  final bool compact;
  const MartellFooter({this.compact = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: compact ? 10 : 40, bottom: compact ? 2 : 10),
      padding: EdgeInsets.symmetric(
        vertical: compact ? 10 : (isMobile ? 24 : 32),
        horizontal: 12,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2c2c2c), Color(0xFF252525)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        border: Border(
          top: BorderSide(color: Color(0xFFFF4D4D), width: 3),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '☀',
            style: TextStyle(
              fontSize: 26,
              color: Color(0xFFFF8C66),
              shadows: [Shadow(color: Color(0x33FF8C66), blurRadius: 10)],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Casa Martell',
            style: TextStyle(
              fontFamily: 'MedievalSharp',
              color: Color(0xFFFF8C66),
              fontSize: compact ? 15 : (isMobile ? 22 : 28),
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: Colors.black54, blurRadius: 3)],
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            '"Não curvados, não quebrados, não subjugados"',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Color(0xFFFF8C66),
              fontSize: 11,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          const Text(
            '© 2025 Game of Thrones - Sistema de Informações. Todos os direitos reservados.',
            style: TextStyle(
              color: Color(0xFFA0A0A0),
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            'Este é um projeto não oficial para fins educacionais.',
            style: TextStyle(
              color: Color(0xFFA0A0A0),
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          const Text(
            'Desenvolvido por Vicente da Casa Martell de Dorne',
            style: TextStyle(
              color: Color(0xFFFF8C66),
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
