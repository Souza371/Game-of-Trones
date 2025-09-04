import 'dart:convert';
import 'package:http/http.dart' as http;

class GameOfThronesAPI {
  static const String baseUrl = 'https://thronesapi.com/api/v2';
  
  static Future<List<dynamic>> getHouses() async {
    final response = await http.get(Uri.parse('$baseUrl/Houses'));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar casas');
    }
  }
  
  static Future<Map<String, dynamic>> getHouse(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/Houses/$id'));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar casa');
    }
  }
}
