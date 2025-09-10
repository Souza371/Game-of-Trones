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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFD8A31A), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
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
                        print('? Erro ao carregar imagem: \\${character.imageUrl}');
                        print('? Erro: \\${error}');
                        return _buildPlaceholderImage(character.fullName);
                      },
                    )
                  : _buildPlaceholderImage(character.fullName),
            ),
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
                    fontSize: 20,
                    fontFamily: 'MedievalSharp',
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  character.title,
                  style: const TextStyle(fontSize: 16, color: Colors.grey, fontFamily: 'MedievalSharp'),
                ),
                const SizedBox(height: 6),
                Text(
                  character.family,
                  style: const TextStyle(fontSize: 16, color: Color(0xFFD8A31A), fontFamily: 'MedievalSharp'),
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
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0] : '?',
          style: const TextStyle(fontSize: 48, fontFamily: 'MedievalSharp'),
        ),
      ),
    );
  }
}
