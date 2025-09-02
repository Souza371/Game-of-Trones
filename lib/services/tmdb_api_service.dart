import 'dart:convert';
import 'package:http/http.dart' as http;

class TmdbApiService {
  static const String apiKey = 'a1a0614784e1c5866ff5793ef73ed244';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  // Busca personagens de Game of Thrones
  static Future<List<Map<String, dynamic>>> searchCharacters(String query) async {
    final url = Uri.parse('$baseUrl/search/tv?api_key=$apiKey&query=Game%20of%20Thrones');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final showId = data['results'][0]['id'];
      // Busca elenco
      final castUrl = Uri.parse('$baseUrl/tv/$showId/credits?api_key=$apiKey');
      final castResponse = await http.get(castUrl);
      if (castResponse.statusCode == 200) {
        final castData = json.decode(castResponse.body);
        final cast = castData['cast'] as List;
        // Filtra pelo nome digitado
        return cast.where((c) => c['name'].toLowerCase().contains(query.toLowerCase())).map((c) => {
          'name': c['name'],
          'character': c['character'],
          'profile_path': c['profile_path'],
        }).toList();
      }
    }
    return [];
  }

  // Retorna URL completa da imagem
  static String getImageUrl(String? path) {
    if (path == null) return '';
    return 'https://image.tmdb.org/t/p/w500$path';
  }
}
