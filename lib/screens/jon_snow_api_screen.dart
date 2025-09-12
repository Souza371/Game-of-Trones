import 'package:flutter/material.dart';
import '../models/character_api_model.dart';

class JonSnowApiScreen extends StatefulWidget {
  const JonSnowApiScreen({Key? key}) : super(key: key);

  @override
  State<JonSnowApiScreen> createState() => _JonSnowApiScreenState();
}

class _JonSnowApiScreenState extends State<JonSnowApiScreen> {
  late Future<CharacterApiModel> _futureCharacter;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jon Snow (API)')),
      body: FutureBuilder<CharacterApiModel>(
        future: _futureCharacter,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: \\${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Nenhum dado encontrado.'));
          }
          final character = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Nome: \\${character.name}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text('Gênero: \\${character.gender}'),
              Text('Cultura: \\${character.culture}'),
              Text('Nascimento: \\${character.born}'),
              Text('Falecimento: \\${character.died.isEmpty ? "Vivo" : character.died}'),
              const SizedBox(height: 12),
              Text('Títulos: \\${character.titles.where((t) => t.isNotEmpty).join(", ")}'),
              const SizedBox(height: 12),
              Text('Apelidos: \\${character.aliases.where((a) => a.isNotEmpty).join(", ")}'),
              const SizedBox(height: 12),
              Text('Séries de TV: \\${character.tvSeries.where((s) => s.isNotEmpty).join(", ")}'),
              const SizedBox(height: 12),
              Text('Ator: \\${character.playedBy.where((p) => p.isNotEmpty).join(", ")}'),
            ],
          );
        },
      ),
    );
  }
}
