import 'package:flutter/material.dart';

class EmblemCreatorScreen extends StatefulWidget {
  @override
  _EmblemCreatorScreenState createState() => _EmblemCreatorScreenState();
}

class _EmblemCreatorScreenState extends State<EmblemCreatorScreen> {
  Color _color = Colors.blue;
  String _shape = 'Circle';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criador de Brasão')), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Escolha a cor:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...[Colors.red, Colors.green, Colors.blue, Colors.yellow].map((c) => GestureDetector(
                  onTap: () => setState(() => _color = c),
                  child: Container(
                    width: 40, height: 40,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: c,
                      shape: BoxShape.circle,
                      border: Border.all(width: _color == c ? 3 : 1, color: Colors.black),
                    ),
                  ),
                ))
              ],
            ),
            SizedBox(height: 24),
            Text('Escolha a forma:'),
            DropdownButton<String>(
              value: _shape,
              items: ['Circle', 'Square', 'Triangle'].map((s) => DropdownMenuItem(
                value: s,
                child: Text(s),
              )).toList(),
              onChanged: (s) => setState(() => _shape = s!),
            ),
            SizedBox(height: 24),
            Text('Visualização:'),
            Container(
              width: 100, height: 100,
              child: CustomPaint(
                painter: _EmblemPainter(_color, _shape),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmblemPainter extends CustomPainter {
  final Color color;
  final String shape;
  _EmblemPainter(this.color, this.shape);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    switch (shape) {
      case 'Circle':
        canvas.drawCircle(Offset(size.width/2, size.height/2), size.width/2, paint);
        break;
      case 'Square':
        canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
        break;
      case 'Triangle':
        final path = Path()
          ..moveTo(size.width/2, 0)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();
        canvas.drawPath(path, paint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
