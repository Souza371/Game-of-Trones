import 'package:flutter/material.dart';

class MartellFooter extends StatelessWidget {
  final bool compact;
  final bool showCredit;
  const MartellFooter({this.compact = false, this.showCredit = false, super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Padding(
      padding: EdgeInsets.only(top: compact ? 10 : 40, bottom: compact ? 2 : 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            '☀',
            style: TextStyle(
              fontSize: 32,
              color: Color(0xFFFF8C66),
              shadows: [Shadow(color: Color(0x33FF8C66), blurRadius: 10)],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Casa Martell',
            style: TextStyle(
              fontFamily: 'MedievalSharp',
              color: const Color(0xFFFF8C66),
              fontSize: isMobile ? 44 : 56,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.7,
              shadows: [Shadow(color: Color(0xFFFFD700).withOpacity(0.7), blurRadius: 22)],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            '"Não curvados, não quebrados, não subjugados"',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Color(0xFFFF8C66),
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.7,
              shadows: [Shadow(color: Color(0xFFFFD700).withOpacity(0.5), blurRadius: 16)],
            ),
            textAlign: TextAlign.center,
          ),
          if (showCredit) ...[
            const SizedBox(height: 18),
            Text(
              'Desenvolvido por Vicente da Casa Martell de Dorne',
              style: TextStyle(
                color: Color(0xFFFF8C66),
                fontWeight: FontWeight.w900,
                fontSize: isMobile ? 22 : 28,
                fontFamily: 'MedievalSharp',
                letterSpacing: 1.2,
                shadows: [Shadow(color: Color(0xFFFFD700).withOpacity(0.5), blurRadius: 10)],
              ),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 12),
          const Text(
            '© 2025 Game of Thrones - Sistema de Informações. Todos os direitos reservados.',
            style: TextStyle(
              color: Color(0xFFA0A0A0),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            'Este é um projeto não oficial para fins educacionais.',
            style: TextStyle(
              color: Color(0xFFA0A0A0),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
