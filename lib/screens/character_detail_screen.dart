import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailScreen({required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.name ?? 'Personagem')), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${character.name ?? "Desconhecido"}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('Casa: ${character.house ?? "Desconhecida"}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 12),
            Text('Gênero: ${character.gender ?? "Desconhecido"}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 12),
            Text('Nascimento: ${character.born ?? "Desconhecido"}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 12),
            Text('Falecimento: ${character.died ?? "Desconhecido"}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 24),
            character.imageUrl != null
                ? Image.network(character.imageUrl!)
                : Container(height: 120, color: Colors.grey[300], child: Center(child: Text('Sem imagem'))),
          ],
        ),
      ),
    );
  }
}
