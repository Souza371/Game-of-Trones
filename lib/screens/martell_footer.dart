import 'package:flutter/material.dart';

class MartellFooter extends StatelessWidget {
  final bool compact;
  final bool showCredit;
  const MartellFooter({this.compact = false, this.showCredit = false, super.key});

  @override
  Widget build(BuildContext context) {
  // final isMobile = MediaQuery.of(context).size.width < 700;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      margin: EdgeInsets.only(top: compact ? 10 : 24, bottom: 0),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.wb_sunny,
                    color: Color(0xFFFFD700),
                    size: 36,
                  ),
                  // Aqui pode adicionar a lança com Image.asset se desejar
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Casa Martell',
                style: TextStyle(
                  fontFamily: 'Cinzel',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFA500),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '"Não curvados, não quebrados, não subjugados"',
                style: TextStyle(
                  fontFamily: 'MedievalSharp',
                  fontSize: 13,
                  color: Color(0xFFFFA500),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              if (showCredit) ...[
                Text(
                  'Desenvolvido por Vicente da Casa Martell de Dorne',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    fontFamily: 'Cinzel',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
              ],
            ],
          ),
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
        ],
      ),
    );
  }
}
