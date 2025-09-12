import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  // String selectedEmblem = 'Stark';
  Color selectedColor = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Jogador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nome:', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Digite seu nome'),
            ),
            const SizedBox(height: 24),
            // Text('Escolha seu brasão:', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              // value: selectedEmblem,
              items: ['Stark', 'Lannister', 'Targaryen', 'Baratheon', 'Greyjoy']
                  .map((house) => DropdownMenuItem(
                        value: house,
                        child: Text(house),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  // selectedEmblem = value!;
                });
              },
            ),
            const SizedBox(height: 24),
            const Text('Escolha sua cor:', style: TextStyle(fontSize: 18)),
            Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => selectedColor = Colors.blueGrey),
                  child: const CircleAvatar(backgroundColor: Colors.blueGrey),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => setState(() => selectedColor = Colors.red),
                  child: const CircleAvatar(backgroundColor: Colors.red),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => setState(() => selectedColor = Colors.yellow),
                  child: const CircleAvatar(backgroundColor: Colors.yellow),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => setState(() => selectedColor = Colors.black),
                  child: const CircleAvatar(backgroundColor: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/search');
                },
                child: const Text('Salvar e Buscar Personagens'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
