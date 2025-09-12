import 'package:flutter/material.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela removida'),
        backgroundColor: const Color(0xFF222831),
        foregroundColor: const Color(0xFFD8A31A),
      ),
      body: const Center(
        child: Text(
          'A tela de citações foi removida.',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
