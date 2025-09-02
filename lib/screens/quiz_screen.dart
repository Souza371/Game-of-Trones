import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestion = 0;
  List<int> _answers = [];

  // Edite, adicione ou remova perguntas como quiser!
  // Exemplo: Pergunta de signo
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
      'question': 'Qual seu signo?',
      'options': ['Áries', 'Touro', 'Gêmeos', 'Câncer', 'Leão', 'Virgem', 'Libra', 'Escorpião', 'Sagitário', 'Capricórnio', 'Aquário', 'Peixes']
    },
    // Adicione aqui outras perguntas personalizadas!
    // Para ter 10 perguntas, basta seguir o modelo acima.
  ];

  void _answer(int index) {
    _answers.add(index);
    if (_currentQuestion < _questions.length - 1) {
      setState(() {
        _currentQuestion++;
      });
    } else {
      // Lógica simples para casa
      final score = _answers.fold(0, (a, b) => a + b);
      String house;
      if (score < 10) house = 'Stark';
      else if (score < 20) house = 'Lannister';
      else if (score < 30) house = 'Targaryen';
      else house = 'Baratheon';
      Navigator.pushReplacementNamed(context, '/house_result', arguments: house);
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_currentQuestion];
    return Scaffold(
      appBar: AppBar(title: Text('Quiz das Casas')), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(q['question'], style: TextStyle(fontSize: 20)),
            SizedBox(height: 24),
            ...List.generate(q['options'].length, (i) => ElevatedButton(
              onPressed: () => _answer(i),
              child: Text(q['options'][i]),
            ))
          ],
        ),
      ),
    );
  }
}
