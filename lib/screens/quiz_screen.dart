
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<_QuizQuestion> _questions = [
    _QuizQuestion(
      question: 'Qual seu signo do zodíaco?',
      options: ['Áries', 'Touro', 'Gêmeos', 'Câncer'],
    ),
    _QuizQuestion(
      question: 'Qual seu maior valor?',
      options: ['Lealdade', 'Ambição', 'Coragem', 'Sabedoria'],
    ),
    _QuizQuestion(
      question: 'O que você mais valoriza em amigos?',
      options: ['Honestidade', 'Poder', 'Aventura', 'Inteligência'],
    ),
    _QuizQuestion(
      question: 'Qual animal você mais se identifica?',
      options: ['Lobo', 'Leão', 'Dragão', 'Corvo'],
    ),
    _QuizQuestion(
      question: 'Qual estação do ano você prefere?',
      options: ['Inverno', 'Verão', 'Primavera', 'Outono'],
    ),
    _QuizQuestion(
      question: 'Qual dessas cores você mais gosta?',
      options: ['Cinza', 'Dourado', 'Vermelho', 'Azul'],
    ),
    _QuizQuestion(
      question: 'Qual dessas frases te define?',
      options: [
        'O inverno está chegando',
        'Ouça-me rugir',
        'Fogo e sangue',
        'Nós não semeamos'
      ],
    ),
    _QuizQuestion(
      question: 'Qual dessas profissões você escolheria?',
      options: ['Líder', 'Estrategista', 'Aventureiro', 'Conselheiro'],
    ),
  ];

  int _currentQuestion = 0;
  List<int> _answers = [];

  void _next(int selected) {
    setState(() {
      _answers.add(selected);
      if (_currentQuestion < _questions.length - 1) {
        _currentQuestion++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizResultScreen(answers: _answers),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_currentQuestion];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz das Casas', style: TextStyle(fontFamily: 'MedievalSharp')),
        backgroundColor: const Color(0xFF222831),
        foregroundColor: const Color(0xFFD8A31A),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/castle_bg.jpg',
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.18),
            colorBlendMode: BlendMode.darken,
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Pergunta ${_currentQuestion + 1} de ${_questions.length}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'MedievalSharp'),
                ),
                const SizedBox(height: 24),
                Text(
                  q.question,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'MedievalSharp'),
                ),
                const SizedBox(height: 32),
                ...List.generate(q.options.length, (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade700,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 18, fontFamily: 'MedievalSharp'),
                    ),
                    onPressed: () => _next(i),
                    child: Text(q.options[i]),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuizQuestion {
  final String question;
  final List<String> options;
  _QuizQuestion({required this.question, required this.options});
}

class QuizResultScreen extends StatelessWidget {
  final List<int> answers;
  const QuizResultScreen({Key? key, required this.answers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simples lógica para associar respostas a casas
    final houseIndex = answers.fold<int>(0, (a, b) => a + b) % 4;
    final houses = [
      _HouseResult('Stark', 'O inverno está chegando', 'https://awoiaf.westeros.org/images/2/24/House_Stark.svg'),
      _HouseResult('Lannister', 'Ouça-me rugir', 'https://awoiaf.westeros.org/images/9/9e/House_Lannister.svg'),
      _HouseResult('Targaryen', 'Fogo e sangue', 'https://awoiaf.westeros.org/images/6/6a/House_Targaryen.svg'),
      _HouseResult('Greyjoy', 'Nós não semeamos', 'https://awoiaf.westeros.org/images/5/52/House_Greyjoy.svg'),
    ];
    final result = houses[houseIndex];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado do Quiz'),
        backgroundColor: const Color(0xFF222831),
        foregroundColor: const Color(0xFFD8A31A),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Você pertence à Casa',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                result.name,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFD8A31A)),
              ),
              const SizedBox(height: 16),
              Image.network(result.emblemUrl, height: 120),
              const SizedBox(height: 24),
              Text(
                result.motto,
                style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                child: const Text('Voltar ao início'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HouseResult {
  final String name;
  final String motto;
  final String emblemUrl;
  _HouseResult(this.name, this.motto, this.emblemUrl);
}
