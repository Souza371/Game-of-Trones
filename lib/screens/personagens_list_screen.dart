import 'package:flutter/material.dart';
import '../data/personagens_data.dart';
import 'personagem_detail_screen.dart';

class PersonagensListScreen extends StatelessWidget {
  const PersonagensListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personagens')),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Agora 4 por linha
          childAspectRatio: 0.7, // Cards mais compactos
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: personagens.length,
        itemBuilder: (context, index) {
          final personagem = personagens[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PersonagemDetailScreen(personagem: personagem),
                ),
              );
            },
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      personagem.imagem,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 60),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      personagem.nome,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
