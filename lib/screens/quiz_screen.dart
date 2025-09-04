import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestion = 0;
  List<int> _answers = [];

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Qual qualidade você mais valoriza?',
      'options': ['Coragem', 'Lealdade', 'Inteligência', 'Ambição']
    },
    {
      'question': 'Qual animal você prefere?',
      'options': ['Lobo', 'Leão', 'Dragão', 'Veado']
    },
    {
      'question': 'Como você age em conflitos?',
      'options': ['Ataco primeiro', 'Busco diplomacia', 'Planejo estrategicamente', 'Recuo e espero']
    },
    {
      'question': 'Qual elemento te representa?',
      'options': ['Gelo', 'Fogo', 'Água', 'Terra']
    },
    {
      'question': 'Qual é seu objetivo de vida?',
      'options': ['Proteger minha família', 'Conquistar poder', 'Buscar liberdade', 'Manter a honra']
    }
  ];

  void _answer(int index) {
    setState(() {
      _answers.add(index);
      if (_currentQuestion < _questions.length - 1) {
        _currentQuestion++;
      } else {
        _calculateResult();
      }
    });
  }

  void _calculateResult() {
    int stark = 0, lannister = 0, targaryen = 0, baratheon = 0;
    
    for (int i = 0; i < _answers.length; i++) {
      if (_answers[i] == 0) stark++;
      if (_answers[i] == 1) lannister++;
      if (_answers[i] == 2) targaryen++;
      if (_answers[i] == 3) baratheon++;
    }
    
    String house;
    if (stark >= lannister && stark >= targaryen && stark >= baratheon) house = 'Stark';
    else if (lannister >= targaryen && lannister >= baratheon) house = 'Lannister';
    else if (targaryen >= baratheon) house = 'Targaryen';
    else house = 'Baratheon';
    
    Navigator.pushReplacementNamed(context, '/house_result', arguments: house);
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_currentQuestion];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz das Casas de Westeros',
          style: TextStyle(
            fontFamily: 'Cinzel',
            fontWeight: FontWeight.bold,
          ),
        ),
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
              // CONTADOR DE PERGUNTAS
              Text(
                'Pergunta ${_currentQuestion + 1}/${_questions.length}',
                style: TextStyle(
                  color: Color(0xFFD8A31A),
                  fontSize: 16,
                  fontFamily: 'Cinzel',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25),
              
              // PERGUNTA
              Text(
                q['question'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Cinzel',
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 35),
              
              // BOTÕES COM ESPAÇAMENTO
              Expanded(
                child: ListView.separated(
                  itemCount: q['options'].length,
                  separatorBuilder: (context, index) => SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () => _answer(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF393E46),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Color(0xFFD8A31A), width: 1),
                        ),
                        elevation: 4,
                      ),
                      child: Text(
                        q['options'][index],
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Cinzel',
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
              
              // BARRA DE PROGRESSO
              SizedBox(height: 20),
              LinearProgressIndicator(
                value: (_currentQuestion + 1) / _questions.length,
                backgroundColor: Color(0xFF393E46),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD8A31A)),
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
