import 'package:flutter/material.dart';
import '../services/house_data.dart';

class HouseResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final houseName = ModalRoute.of(context)?.settings.arguments as String? ?? houses[0].name;
    final house = houses.firstWhere((h) => h.name == houseName, orElse: () => houses[0]);
    return Scaffold(
      appBar: AppBar(title: Text('Sua Casa')), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Você pertence à Casa ${house.name}!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            Image.network(house.emblemUrl, height: 120),
            SizedBox(height: 16),
            Text(house.motto, style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
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
}
