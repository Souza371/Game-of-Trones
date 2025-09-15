import 'package:flutter/material.dart';
import '../data/models/personagem.dart';

class PersonagemDetailScreen extends StatelessWidget {
  final Personagem personagem;
  const PersonagemDetailScreen({Key? key, required this.personagem}) : super(key: key);

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFFC8A971)),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ],
    );
  }

  Widget _buildList(List<String> items) {
    if (items.isEmpty) return const Text('-');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((e) => Text('• $e')).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(personagem.nome)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: personagem.imagem.isNotEmpty
                    ? Image.asset(
                        personagem.imagem,
                        height: 220,
                        width: 220,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 120),
                      )
                    : const Icon(Icons.person, size: 120),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Casa', Icons.shield),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4, bottom: 12),
              child: Text(personagem.casa.isNotEmpty ? personagem.casa : '-'),
            ),
            _buildSectionTitle('Títulos', Icons.emoji_events),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4, bottom: 12),
              child: _buildList(personagem.titulos),
            ),
            _buildSectionTitle('Status', Icons.info_outline),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4, bottom: 12),
              child: Text(personagem.status.isNotEmpty ? personagem.status : '-'),
            ),
            _buildSectionTitle('Aliados', Icons.group),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4, bottom: 12),
              child: _buildList(personagem.aliados),
            ),
            _buildSectionTitle('História', Icons.menu_book),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4, bottom: 12),
              child: Text(personagem.historia.isNotEmpty ? personagem.historia : '-'),
            ),
          ],
        ),
      ),
    );
  }
}
