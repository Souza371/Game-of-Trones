import 'dart:convert';
import 'package:http/http.dart' as http;

class QuotesApiService {
  static const String baseUrl = 'https://game-of-thrones-quotes.herokuapp.com/v1';

  // Busca uma citação aleatória
  static Future<Map<String, dynamic>?> getRandomQuote() async {
    final url = Uri.parse('$baseUrl/random');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List && data.isNotEmpty) {
        return data[0];
      }
    }
    return null;
  }
}
