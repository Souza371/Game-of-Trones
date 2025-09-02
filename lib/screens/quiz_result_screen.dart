import 'package:flutter/material.dart';

class QuizResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final answers = ModalRoute.of(context)!.settings.arguments as List<int>? ?? [];
    final house = _getHouseFromAnswers(answers);
    return Scaffold(
      appBar: AppBar(title: Text('Resultado do Quiz')), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Você pertence à casa:', style: TextStyle(fontSize: 20)),
            SizedBox(height: 16),
            Text(house, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
              child: Text('Voltar ao início'),
            )
          ],
        ),
      ),
    );
  }

  String _getHouseFromAnswers(List<int> answers) {
    if (answers.isEmpty) return 'Desconhecida';
    // Lógica simples: soma dos índices das respostas
    final score = answers.fold(0, (a, b) => a + b);
    if (score < 10) return 'Stark';
    if (score < 20) return 'Lannister';
    if (score < 30) return 'Targaryen';
    return 'Baratheon';
  }
}
