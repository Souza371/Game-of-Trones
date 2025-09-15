
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:just_audio/just_audio.dart';
import 'westeros_map_screen.dart';
import 'characters_screen.dart';
import 'quiz_screen.dart';
// Imagem de fundo do castelo
const String castleBg = 'assets/images/castle_bg.jpg';

// Widget de botão principal do menu
class _MenuItem extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  final bool small;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    this.small = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.72),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xFFC8A971), width: 2),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.18), blurRadius: 6, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Text(
              icon,
              style: TextStyle(fontSize: small ? 28 : 36),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Color(0xFFFFD700),
                      fontFamily: 'MedievalSharp',
                      fontWeight: FontWeight.bold,
                      fontSize: small ? 20 : 26,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: small ? 13 : 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final AudioPlayer? player;
  final bool? isPlaying;
  final bool? showMusicButton;
  final Future<void> Function()? onStartMusic;
  final ValueChanged<double>? onVolumeChanged;
  const HomeScreen({
    super.key,
    this.player,
    this.isPlaying,
    this.showMusicButton,
    this.onStartMusic,
    this.onVolumeChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // double _volume = 1.0; // Removido pois não está sendo usado
  bool _showVolume = false;

  double _volume = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 36,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 4),
            child: Tooltip(
              message: widget.isPlaying == true ? 'Volume da música' : 'Ativar música de fundo',
              child: _PulsingMusicButton(
                onPressed: widget.isPlaying == true
                    ? () async => setState(() => _showVolume = !_showVolume)
                    : widget.onStartMusic,
                isPlaying: widget.isPlaying ?? false,
                tooltip: widget.isPlaying == true ? 'Volume da música' : 'Ativar música de fundo',
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              castleBg,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Game of Thrones',
                  style: TextStyle(
                    color: Color(0xFFFFD700),
                    fontSize: 44,
                    fontFamily: 'MedievalSharp',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    shadows: [
                      Shadow(
                        color: Colors.black87,
                        offset: Offset(3, 3),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _CircularMenu(),
                const SizedBox(height: 32),
                SizedBox(
                  width: 340,
                  child: Column(
                    children: [
                      _MenuItem(
                        icon: '🗺️',
                        title: 'Mapa de Westeros',
                        description: 'Explore o mapa do mundo de Game of Thrones',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => WesterosMapScreen()),
                          );
                        },
                        small: true,
                      ),
                      const SizedBox(height: 10),
                      _MenuItem(
                        icon: '👑',
                        title: 'Personagens',
                        description: 'Veja os personagens principais',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const CharactersScreen()),
                          );
                        },
                        small: true,
                      ),
                      const SizedBox(height: 10),
                      _MenuItem(
                        icon: '❓',
                        title: 'Quiz',
                        description: 'Teste seus conhecimentos',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => QuizScreen()),
                          );
                        },
                        small: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_showVolume && (widget.player != null) && !(widget.showMusicButton ?? false))
            Positioned(
              top: 60,
              right: 24,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.92),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xFFFFD700), width: 2.5),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Volume', style: TextStyle(color: Color(0xFFFFD700), fontFamily: 'MedievalSharp', fontSize: 22, fontWeight: FontWeight.bold)),
                      Slider(
                        value: _volume,
                        min: 0,
                        max: 1,
                        divisions: 20,
                        onChanged: (v) {
                          setState(() => _volume = v);
                          widget.onVolumeChanged?.call(v);
                        },
                        activeColor: const Color(0xFFFFD700),
                        inactiveColor: Colors.grey,
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Color(0xFFFFD700), size: 36),
                        onPressed: () => setState(() => _showVolume = false),
                        tooltip: 'Fechar',
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PulsingMusicButton extends StatefulWidget {
  final Future<void> Function()? onPressed;
  final String tooltip;
  final bool isPlaying;
  const _PulsingMusicButton({
    required this.onPressed,
    required this.tooltip,
    required this.isPlaying,
    Key? key,
  }) : super(key: key);

  @override
  State<_PulsingMusicButton> createState() => _PulsingMusicButtonState();
}

class _PulsingMusicButtonState extends State<_PulsingMusicButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: _loading
              ? null
              : () async {
                  if (widget.onPressed != null) {
                    setState(() => _loading = true);
                    await widget.onPressed!();
                    setState(() => _loading = false);
                  }
                },
          child: Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.10),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFFFD700), width: 5),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 16, offset: Offset(0, 6)),
              ],
            ),
            child: Center(
              child: _loading
                  ? const CircularProgressIndicator(color: Color(0xFFFFD700))
                  : widget.isPlaying
                      ? CustomPaint(
                          size: const Size(70, 90),
                          painter: _MusicNotePainter(color: const Color(0xFFFFD700)),
                        )
                      : Icon(Icons.play_arrow, color: const Color(0xFFFFD700), size: 60),
            ),
          ),
        ),
      ),
    );
  }
}

class _MusicNotePainter extends CustomPainter {
  final Color color;
  _MusicNotePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Desenha a haste
    final stemWidth = size.width * 0.09;
    final stemHeight = size.height * 0.7;
    final stemLeft = size.width * 0.55;
    final stemTop = size.height * 0.08;
    final stemRect = Rect.fromLTWH(stemLeft, stemTop, stemWidth, stemHeight);
    canvas.drawRect(stemRect, paint);

    // Desenha a bolinha
    final noteRadius = size.width * 0.23;
    final noteCenter = Offset(size.width * 0.59, size.height * 0.78);
    canvas.drawCircle(noteCenter, noteRadius, paint);

    // Desenha a "barriga" da nota (curva)
    final path = Path();
    path.moveTo(stemLeft + stemWidth, stemTop + stemHeight * 0.15);
    path.quadraticBezierTo(
      size.width * 0.95, size.height * 0.25,
      size.width * 0.85, size.height * 0.55,
    );
    path.quadraticBezierTo(
      size.width * 0.80, size.height * 0.65,
      noteCenter.dx, noteCenter.dy - noteRadius * 0.7,
    );
    final curvePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.09
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, curvePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Menu circular (roda de entes)
class _CircularMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Exemplo visual simples (substitua pelo seu menu circular real se desejar)
    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (int i = 0; i < 6; i++)
            Transform.rotate(
              angle: i * 1.047,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    border: Border.all(color: Color(0xFFC8A971), width: 2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      String.fromCharCode(0x2654 + i), // Peças de xadrez unicode
                      style: const TextStyle(fontSize: 28, color: Color(0xFFFFD700)),
                    ),
                  ),
                ),
              ),
            ),
          // Centro
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFC8A971),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 8),
              ],
            ),
            child: const Center(
              child: Icon(Icons.shield, color: Colors.black, size: 36),
            ),
          ),
        ],
      ),
    );
  }
}

// Fim da classe _PulsingMusicButton

// O bloco abaixo deve estar dentro do método build da classe _HomeScreenState, logo após o Scaffold:
//
// if (_showVolume && kIsWeb && (widget.player != null) && !(widget.showMusicButton ?? false))
//   Positioned(
//     top: 60,
//     right: 24,
//     child: Material(
//       color: Colors.transparent,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.black.withOpacity(0.92),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Color(0xFFC8A971), width: 1.5),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text('Volume', style: TextStyle(color: Color(0xFFC8A971), fontFamily: 'MedievalSharp', fontSize: 18)),
//             Slider(
//               value: _volume,
//               min: 0,
//               max: 1,
//               divisions: 20,
//               onChanged: (v) {
//                 setState(() => _volume = v);
//                 widget.onVolumeChanged?.call(v);
//               },
//               activeColor: const Color(0xFFC8A971),
//               inactiveColor: Colors.grey,
//             ),
//             IconButton(
//               icon: const Icon(Icons.close, color: Color(0xFFC8A971)),
//               onPressed: () => setState(() => _showVolume = false),
//               tooltip: 'Fechar',
//             ),
//           ],
//         ),
//       ),
//     ),
//   ),

