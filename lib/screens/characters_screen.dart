import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/character_model.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character> characters = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    try {
      final charactersList = await ApiService.getCharacters();
      setState(() {
        characters = charactersList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens de Game of Thrones'),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : characters.isEmpty
            ? const Center(child: Text('Nenhum personagem encontrado'))
            : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  final character = characters[index];
                  return CharacterCard(character: character);
                },
              ),
    );
  }
}

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: character.imageUrl.isNotEmpty
                ? Image.network(
                    character.imageUrl,
                    fit: BoxFit.cover,
                    headers: const {'Cache-Control': 'no-cache'},
                    cacheWidth: 150,
                    cacheHeight: 200,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / 
                                loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      print('? Erro ao carregar imagem: ${character.imageUrl}');
                      print('? Erro: $error');
                      return _buildPlaceholderImage(character.fullName);
                    },
                  )
                : _buildPlaceholderImage(character.fullName),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  character.fullName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Casa: ${character.family.isNotEmpty ? character.family : 'Desconhecida'}',
                  style: TextStyle(
                    color: _getHouseColor(character.family),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (character.title.isNotEmpty)
                  Text(
                    character.title,
                    style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                // Debug: mostra a URL da imagem
                Text(
                  'Imagem: ${character.imageUrl}',
                  style: const TextStyle(fontSize: 8, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage(String name) {
    return Container(
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person, size: 40, color: Colors.grey),
          const SizedBox(height: 8),
          Text(
            name.split(' ').first,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Color _getHouseColor(String house) {
    final houseLower = house.toLowerCase();
    if (houseLower.contains('stark')) return Colors.grey[800]!;
    if (houseLower.contains('targaryen')) return Colors.red[800]!;
    if (houseLower.contains('lannister')) return Colors.amber[800]!;
    if (houseLower.contains('baratheon')) return Colors.yellow[800]!;
    if (houseLower.contains('tyrell')) return Colors.green[800]!;
    if (houseLower.contains('martell')) return Colors.orange[800]!;
    if (houseLower.contains('unknown')) return Colors.purple;
    return Colors.blue;
  }
}
