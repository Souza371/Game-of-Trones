import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WesterosMapScreen extends StatelessWidget {
  const WesterosMapScreen({Key? key}) : super(key: key);

  final String mapImageUrl =
      'https://awoiaf.westeros.org/images/5/5a/Map_of_westeros.jpg';
  final String mapSourceUrl =
      'https://awoiaf.westeros.org/index.php/Maps_of_Westeros';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Westeros', style: TextStyle(fontFamily: 'MedievalSharp')),
        backgroundColor: const Color(0xFF222831),
        foregroundColor: const Color(0xFFD8A31A),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.18), BlendMode.darken),
            child: Image.network(
              mapImageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) => Center(
                child: Text('Erro ao carregar o mapa'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black.withOpacity(0.7),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontFamily: 'MedievalSharp', fontSize: 16),
                ),
                onPressed: () async {
                  if (await canLaunchUrl(Uri.parse(mapSourceUrl))) {
                    launchUrl(Uri.parse(mapSourceUrl));
                  }
                },
                icon: const Icon(Icons.open_in_new),
                label: const Text('Ver fonte', style: TextStyle(fontFamily: 'MedievalSharp')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
