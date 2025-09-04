import 'dart:convert';
import 'package:http/http.dart' as http;

class IceAndFireAPI {
  static const String baseUrl = 'https://anapioficeandfire.com/api';
  
  // Buscar personagens
  static Future<List<dynamic>> getCharacters({int page = 1, int pageSize = 10}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/characters?page=$page&pageSize=$pageSize')
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar personagens');
    }
  }
  
  // Buscar casas
  static Future<List<dynamic>> getHouses({int page = 1, int pageSize = 10}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/houses?page=$page&pageSize=$pageSize')
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar casas');
    }
  }
  
  // Buscar livros
  static Future<List<dynamic>> getBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/books'));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar livros');
    }
  }
}
