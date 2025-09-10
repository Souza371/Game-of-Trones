import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
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
        title: Text('Perfil do Jogador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome:', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Digite seu nome'),
            ),
            SizedBox(height: 24),
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
            SizedBox(height: 24),
            Text('Escolha sua cor:', style: TextStyle(fontSize: 18)),
            Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => selectedColor = Colors.blueGrey),
                  child: CircleAvatar(backgroundColor: Colors.blueGrey),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () => setState(() => selectedColor = Colors.red),
                  child: CircleAvatar(backgroundColor: Colors.red),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () => setState(() => selectedColor = Colors.yellow),
                  child: CircleAvatar(backgroundColor: Colors.yellow),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () => setState(() => selectedColor = Colors.black),
                  child: CircleAvatar(backgroundColor: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/search');
                },
                child: Text('Salvar e Buscar Personagens'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
