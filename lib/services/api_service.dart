import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';

class ApiService {
  static const String baseUrl = 'https://thronesapi.com/api/v2';

  static Future<List<Character>> getCharacters() async {
    try {
      print('?? Conectando com: $baseUrl/Characters');
      final response = await http.get(Uri.parse('$baseUrl/Characters'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('? Sucesso! ${data.length} personagens carregados');
        
        // Converte para lista de Character
        return data.map((json) => Character.fromJson(json)).toList();
      } else {
        print('? Erro HTTP: ${response.statusCode}');
        throw Exception('Falha ao carregar: Status ${response.statusCode}');
      }
    } catch (e) {
      print('? Erro de conexão: $e');
      throw Exception('Não foi possível conectar à API: $e');
    }
  }
}
