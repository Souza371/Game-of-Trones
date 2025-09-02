import 'package:flutter/material.dart';
import '../services/tmdb_api_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _results = [];
  bool _isLoading = false;

  void _searchCharacters(String query) async {
    setState(() { _isLoading = true; });
    final results = await TmdbApiService.searchCharacters(query);
    setState(() {
      _results = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buscar Personagens')), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Digite o nome do personagem',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                if (value.length > 2) _searchCharacters(value);
              },
            ),
            SizedBox(height: 16),
            _isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        final character = _results[index];
                        return ListTile(
                          leading: character['profile_path'] != null && character['profile_path'] != ''
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(TmdbApiService.getImageUrl(character['profile_path'])),
                                )
                              : CircleAvatar(child: Icon(Icons.person)),
                          title: Text(character['name'] ?? 'Sem nome'),
                          subtitle: Text(character['character'] ?? ''),
                          onTap: () {
                            // Navegar para tela de detalhes
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
