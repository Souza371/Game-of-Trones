import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;
// Para evitar erro de importação do WebView no Windows, import condicional
// ignore: uri_does_not_exist
// import 'package:webview_flutter/webview_flutter.dart' if (dart.library.io) 'package:webview_flutter/webview_flutter.dart';

class WesterosMapScreen extends StatelessWidget {
  const WesterosMapScreen({super.key});

  static const String mapUrl = 'https://quartermaester.info/?layers=electoral';

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || (Platform.isWindows)) {
      // Web e Windows: abre no navegador externo automaticamente
      Future.microtask(() async {
        if (await canLaunchUrl(Uri.parse(mapUrl))) {
          await launchUrl(Uri.parse(mapUrl), mode: LaunchMode.externalApplication);
        }
        if (context.mounted) Navigator.of(context).pop();
      });
      return Scaffold(
        appBar: AppBar(
          title: const Text('Mapa Interativo de Westeros', style: TextStyle(fontFamily: 'MedievalSharp')),
          backgroundColor: const Color(0xFF222831),
          foregroundColor: const Color(0xFFD8A31A),
        ),
        body: const Center(
          child: Text('Abrindo mapa no navegador...'),
        ),
      );
    } else {
      // Android/iOS: (WebView real, se possível)
      return Scaffold(
        appBar: AppBar(
          title: const Text('Mapa Interativo de Westeros', style: TextStyle(fontFamily: 'MedievalSharp')),
          backgroundColor: const Color(0xFF222831),
          foregroundColor: const Color(0xFFD8A31A),
        ),
        body: const Center(
          child: Text(
            'O mapa interativo seria exibido aqui via WebView. (Ative o Developer Mode para usar no Windows)\nSe estiver no Android/iOS, adicione o widget WebView aqui.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }
}
