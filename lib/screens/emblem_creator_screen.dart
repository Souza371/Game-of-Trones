import 'package:flutter/material.dart';

class EmblemCreatorScreen extends StatelessWidget {
  const EmblemCreatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criador de Bras�o'),
      ),
      body: const Center(
        child: Text('Criador de bras�o em desenvolvimento...'),
      ),
    );
  }
}
