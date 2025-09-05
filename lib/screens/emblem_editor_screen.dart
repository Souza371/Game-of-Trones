
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class EmblemEditorScreen extends StatefulWidget {
  @override
  _EmblemEditorScreenState createState() => _EmblemEditorScreenState();
}

class _EmblemEditorScreenState extends State<EmblemEditorScreen> {
  // Opções personalizáveis
  String _selectedShape = 'Retangular';
  Color _backgroundColor = Colors.red;
  Color _letterColor = Colors.white;
  String _letter = 'A';
  
  // Lista de formas disponíveis
  final List<String> _shapes = [
    'Retangular',
    'Quadrada', 
    'Triangular',
    'Cauda-de-andorinha',
    'Flâmula'
  ];
  
  // Lista de letras disponíveis
  final List<String> _letters = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];

  // Cores pré-definidas
  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.black,
    Colors.white,
    Colors.brown,
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editor de Brasão'),
        backgroundColor: Color(0xFF222831),
        foregroundColor: Color(0xFFD8A31A),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveEmblem,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1B1B1B),
              Color(0xFF222831),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // PREVIEW DO BRASÃO
              Expanded(
                child: Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: _backgroundColor,
                      border: Border.all(color: Color(0xFFD8A31A), width: 3),
                      borderRadius: _getBorderRadius(),
                    ),
                    child: Center(
                      child: Text(
                        _letter,
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: _letterColor,
                          fontFamily: 'Cinzel',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              // OPÇÕES DE PERSONALIZAÇÃO
              Expanded(
                child: ListView(
                  children: [
                    // FORMA DO ESCUDO
                    _buildOptionSection(
                      title: 'Forma do Escudo',
                      child: DropdownButton<String>(
                        value: _selectedShape,
                        items: _shapes.map((String shape) {
                          return DropdownMenuItem<String>(
                            value: shape,
                            child: Text(shape),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedShape = newValue!;
                          });
                        },
                      ),
                    ),
                    
                    // LETRA CENTRAL
                    _buildOptionSection(
                      title: 'Letra Central',
                      child: DropdownButton<String>(
                        value: _letter,
                        items: _letters.map((String letter) {
                          return DropdownMenuItem<String>(
                            value: letter,
                            child: Text(letter, style: TextStyle(fontSize: 20)),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _letter = newValue!;
                          });
                        },
                      ),
                    ),
                    
                    // COR DE FUNDO
                    _buildOptionSection(
                      title: 'Cor de Fundo',
                      child: Wrap(
                        spacing: 10,
                        children: _colors.map((color) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _backgroundColor = color;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: color,
                                border: Border.all(
                                  color: _backgroundColor == color ? Color(0xFFD8A31A) : Colors.grey,
                                  width: 3
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    
                    // COR DA LETRA
                    _buildOptionSection(
                      title: 'Cor da Letra',
                      child: Wrap(
                        spacing: 10,
                        children: _colors.map((color) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _letterColor = color;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: color,
                                border: Border.all(
                                  color: _letterColor == color ? Color(0xFFD8A31A) : Colors.grey,
                                  width: 3
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildOptionSection({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFFD8A31A),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cinzel',
            ),
          ),
          SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
  
  BorderRadius _getBorderRadius() {
    switch (_selectedShape) {
      case 'Quadrada':
        return BorderRadius.circular(10);
      case 'Triangular':
        return BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        );
      case 'Cauda-de-andorinha':
        return BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        );
      case 'Flâmula':
        return BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(20),
        );
      default: // Retangular
        return BorderRadius.circular(5);
    }
  }
  
  void _saveEmblem() async {
    try {
      // Cria o diretório para salvar
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/meu_brasao.txt');
      
      // Prepara os dados para salvar
      final data = '''
BRASÃO PERSONALIZADO:
- Forma: $_selectedShape
- Cor de Fundo: ${_backgroundColor.toString()}
- Cor da Letra: ${_letterColor.toString()}
- Letra: $_letter
- Data: ${DateTime.now()}
''';
      
      // Salva automaticamente
      await file.writeAsString(data);
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('✅ Brasão Salvo Automaticamente!'),
          content: Text('Arquivo salvo em: ${file.path}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      
      print('Arquivo salvo automaticamente: ${file.path}');
      
    } catch (e) {
      print('Erro ao salvar: $e');
    }
  }
}
