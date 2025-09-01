import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback onTap;
  const CharacterCard({required this.character, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(character.name ?? 'Sem nome'),
        subtitle: Text(character.house ?? 'Casa desconhecida'),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
