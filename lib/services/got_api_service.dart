import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class GotApiService {
  static Future<List<Character>> searchCharacters(String query) async {
    final url = Uri.parse('https://anapioficeandfire.com/api/characters?name=$query');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Character.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}
