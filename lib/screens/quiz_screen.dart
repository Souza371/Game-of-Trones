import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestion = 0;
  List<String> _answers = [];

  // Sistema de pontuação por casa
  Map<String, int> _houseScores = {
    'Stark': 0,
    'Lannister': 0,
    'Targaryen': 0,
    'Baratheon': 0,
    'Greyjoy': 0,
    'Tyrell': 0,
    'Martell': 0,
    'Arryn': 0,
  };

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Qual qualidade você mais valoriza?',
      'options': ['Honra', 'Poder', 'Liberdade', 'Justiça'],
      'scores': {'Stark': 3, 'Lannister': 2, 'Targaryen': 1, 'Baratheon': 2, 'Greyjoy': 1, 'Tyrell': 1, 'Martell': 2, 'Arryn': 3}
    },
    {
      'question': 'Qual animal você prefere?',
      'options': ['Lobo', 'Leão', 'Dragão', 'Veado', 'Lula', 'Rosa', 'Sol', 'Falcão'],
      'scores': {'Stark': 3, 'Lannister': 3, 'Targaryen': 3, 'Baratheon': 3, 'Greyjoy': 3, 'Tyrell': 3, 'Martell': 3, 'Arryn': 3}
    },
    {
      'question': 'Como você resolve conflitos?',
      'options': ['Diplomacia', 'Força', 'Estratégia', 'Fuga'],
      'scores': {'Stark': 2, 'Lannister': 3, 'Targaryen': 3, 'Baratheon': 3, 'Greyjoy': 1, 'Tyrell': 2, 'Martell': 2, 'Arryn': 2}
    },
    {
      'question': 'Qual é seu elemento preferido?',
      'options': ['Gelo', 'Fogo', 'Água', 'Terra', 'Metal', 'Planta', 'Areia', 'Ar'],
      'scores': {'Stark': 3, 'Lannister': 2, 'Targaryen': 3, 'Baratheon': 2, 'Greyjoy': 3, 'Tyrell': 3, 'Martell': 3, 'Arryn': 3}
    },
    {
      'question': 'Qual virtude é mais importante?',
      'options': ['Lealdade', 'Ambição', 'Coragem', 'Determinação', 'Independência', 'Crescimento', 'Paixão', 'Honra'],
      'scores': {'Stark': 3, 'Lannister': 3, 'Targaryen': 2, 'Baratheon': 2, 'Greyjoy': 3, 'Tyrell': 3, 'Martell': 3, 'Arryn': 3}
    }
  ];

  void _answer(int index) {
    final answer = _questions[_currentQuestion]['options'][index];
    _answers.add(answer);
    
    // Adiciona pontos para cada casa baseado na resposta
    final scores = _questions[_currentQuestion]['scores'];
    scores.forEach((house, points) {
      _houseScores[house] = _houseScores[house]! + (points as int); // CORREÇÃO AQUI
    });

    if (_currentQuestion < _questions.length - 1) {
      setState(() {
        _currentQuestion++;
      });
    } else {
      _calculateResult();
    }
  }

  void _calculateResult() {
    // Encontra a casa com maior pontuação
    String winningHouse = 'Stark';
    int highestScore = 0;
    
    _houseScores.forEach((house, score) {
      if (score > highestScore) {
        highestScore = score;
        winningHouse = house;
      }
    });
    
    Navigator.pushReplacementNamed(context, '/house_result', arguments: winningHouse);
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_currentQuestion];
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz das Casas de Westeros'),
        backgroundColor: Color(0xFF222831),
        foregroundColor: Color(0xFFD8A31A),
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Pergunta ${_currentQuestion + 1}/${_questions.length}',
                style: TextStyle(
                  color: Color(0xFFD8A31A),
                  fontSize: 16,
                  fontFamily: 'Cinzel',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                q['question'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Cinzel',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ...List.generate(q['options'].length, (i) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                  onPressed: () => _answer(i),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF393E46),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    q['options'][i],
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Cinzel',
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
