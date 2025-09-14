import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../services/api_service.dart';
import '../models/character_model.dart';
// Imagem de fundo do castelo
const String castleBg = 'assets/images/castle_bg.jpg';

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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              castleBg,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.35),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          // Conteúdo principal
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : characters.isEmpty
                ? const Center(child: Text('Nenhum personagem encontrado'))
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Mais colunas, cards menores
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8, // Cards mais compactos
                    ),
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      final character = characters[index];
                      return CharacterCard(character: character);
                    },
                  ),
        ],
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: character.imageUrl.isNotEmpty
                      ? _SmartCharacterImage(
                          url: character.imageUrl,
                          placeholder: _buildPlaceholderImage(character.fullName),
                        )
                      : _buildPlaceholderImage(character.fullName),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    character.fullName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'MedievalSharp',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    character.title,
                    style: const TextStyle(fontSize: 16, color: Colors.grey, fontFamily: 'MedievalSharp'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    character.family,
                    style: const TextStyle(fontSize: 16, color: Color(0xFFD8A31A), fontFamily: 'MedievalSharp'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
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

// Força recarregar limpando o cache interno do CachedNetworkImage.
void _retryImage(String url) {
  // O provider interno usa url como chave; ao remover manualmente pode-se tentar outra vez.
  CachedNetworkImage.evictFromCache(url);
}

class _SmartCharacterImage extends StatefulWidget {
  final String url;
  final Widget placeholder;
  const _SmartCharacterImage({required this.url, required this.placeholder});

  @override
  State<_SmartCharacterImage> createState() => _SmartCharacterImageState();
}

class _SmartCharacterImageState extends State<_SmartCharacterImage> {
  int _bust = 0;
  bool _fallback = false; // Usa Image.network como último recurso.
  static const String _proxyBase = 'http://localhost:8081/image?url='; // Ajustar conforme necessário.

  Map<String, String>? get _headers => kIsWeb
      ? null // Web ignora/filtra muitos headers; evitar para não provocar erro.
      : const {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36',
          'Accept': 'image/avif,image/webp,image/apng,image/jpeg,image/*,*/*;q=0.8',
          'Accept-Language': 'en-US,en;q=0.9',
          'Cache-Control': 'no-cache'
        };

  String get _effectiveUrl {
    final base = _bust == 0
        ? widget.url
        : '${widget.url}${widget.url.contains('?') ? '&' : '?'}cb=$_bust';
    if (kIsWeb) {
      return '$_proxyBase${Uri.encodeFull(base)}';
    }
    return base;
  }

  void _retry() {
    if (!_fallback) {
      CachedNetworkImage.evictFromCache(_effectiveUrl);
    }
    setState(() {
      _bust++;
      // Depois de duas tentativas, muda para fallback simples.
      if (_bust > 2) _fallback = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_fallback) {
      return Image.network(
        _effectiveUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _errorOverlay(),
        loadingBuilder: (c, child, progress) {
          if (progress == null) return child;
            return Stack(
              fit: StackFit.expand,
              children: [
                widget.placeholder,
                Container(
                  color: Colors.black.withOpacity(0.15),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ],
            );
        },
      );
    }

    return CachedNetworkImage(
      imageUrl: _effectiveUrl,
      httpHeaders: _headers,
      fit: BoxFit.cover,
      placeholder: (context, url) => Stack(
        fit: StackFit.expand,
        children: [
          widget.placeholder,
          Container(
            color: Colors.black.withOpacity(0.15),
            child: const Center(child: CircularProgressIndicator()),
          )
        ],
      ),
      errorWidget: (context, url, error) {
        debugPrint('[SmartImageError] url=$url bust=$_bust fallback=$_fallback error=$error');
        return _errorOverlay();
      },
    );
  }

  Widget _errorOverlay() {
    return GestureDetector(
      onTap: _retry,
      child: Stack(
        fit: StackFit.expand,
        children: [
          widget.placeholder,
          Container(
            color: Colors.black.withOpacity(0.45),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh, color: Colors.white70, size: 40),
                  SizedBox(height: 8),
                  Text('Recarregar', style: TextStyle(color: Colors.white70, fontFamily: 'MedievalSharp')),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
