import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class WesterosMapScreen extends StatelessWidget {
  const WesterosMapScreen({super.key});

  final String mapUrl = 'https://quartermaester.info/?layers=electoral';

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // Para web, abre em nova aba
      return Scaffold(
        appBar: AppBar(
          title: const Text('Mapa Interativo de Westeros', style: TextStyle(fontFamily: 'MedievalSharp')),
          backgroundColor: const Color(0xFF222831),
          foregroundColor: const Color(0xFFD8A31A),
        ),
        body: Center(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.map),
            label: const Text('Abrir Mapa Interativo'),
            onPressed: () {
              launchUrl(Uri.parse(mapUrl), mode: LaunchMode.externalApplication);
            },
          ),
        ),
      );
    } else {
      // Para mobile/desktop, apenas mostra instrução
      return Scaffold(
        appBar: AppBar(
          title: const Text('Mapa Interativo de Westeros', style: TextStyle(fontFamily: 'MedievalSharp')),
          backgroundColor: const Color(0xFF222831),
          foregroundColor: const Color(0xFFD8A31A),
        ),
        body: const Center(
          child: Text(
            'O mapa interativo está disponível apenas na versão web.\nAcesse pelo navegador para explorar os distritos eleitorais de Westeros.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }
}
