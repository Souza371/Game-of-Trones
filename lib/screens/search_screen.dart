import 'package:flutter/material.dart';
import '../services/got_api_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Character> _results = [];
  bool _isLoading = false;

  void _searchCharacters(String query) async {
    setState(() { _isLoading = true; });
    final results = await GotApiService.searchCharacters(query);
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
                          title: Text(character.name ?? 'Sem nome'),
                          subtitle: Text(character.house ?? 'Casa desconhecida'),
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
