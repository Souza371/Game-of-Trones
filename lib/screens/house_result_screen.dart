import 'package:flutter/material.dart';
import '../services/house_data.dart';

class HouseResultScreen extends StatelessWidget {
  const HouseResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final houseName = ModalRoute.of(context)?.settings.arguments as String? ?? houses[0].name;
    final house = houses.firstWhere((h) => h.name == houseName, orElse: () => houses[0]);
    return Scaffold(
      appBar: AppBar(title: const Text('Sua Casa')), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Você pertence à Casa ${house.name}!', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            // Image.network(house.emblemUrl, height: 120),
            const SizedBox(height: 16),
            Text(house.motto, style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
              child: const Text('Voltar ao início'),
            )
          ],
        ),
      ),
    );
  }
}
