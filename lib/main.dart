import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'screens/home_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late final AudioPlayer _player;
  bool _isPlaying = false;
  bool _showOverlay = kIsWeb;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _player = AudioPlayer();
    if (!kIsWeb) {
      _initAudio();
    }
  }

  Future<void> _initAudio() async {
    try {
      await _player.setAsset('assets/audio/tema-de-abertura--oppening-theme-versão-completafull-version.mp3');
      _player.setLoopMode(LoopMode.one);
      await _player.play();
      setState(() => _isPlaying = true);
    } catch (e) {
      debugPrint('Erro ao iniciar áudio: $e');
    }
  }

  void _startAudioWeb() async {
    await _initAudio();
    setState(() {
      _showOverlay = false;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.pause();
    } else if (state == AppLifecycleState.resumed && !_isPlaying) {
      _player.play();
      setState(() => _isPlaying = true);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game of Thrones',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1a1a1a),
        fontFamily: 'Roboto',
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFC8A971), // dourado
          secondary: Color(0xFF8B0000),
          surface: Color(0xFF2c2c2c),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1a1a1a),
          foregroundColor: Color(0xFFC8A971),
          elevation: 8,
          titleTextStyle: TextStyle(
            fontFamily: 'MedievalSharp',
            fontSize: 26,
            color: Color(0xFFC8A971),
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.black54, offset: Offset(2,2), blurRadius: 4)],
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF2c2c2c),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xFFC8A971), width: 1.5),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC8A971),
            foregroundColor: const Color(0xFF1a1a1a),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
        ),
        textTheme: ThemeData.dark().textTheme.copyWith(
          headlineLarge: const TextStyle(fontFamily: 'MedievalSharp', color: Color(0xFFC8A971)),
          headlineMedium: const TextStyle(fontFamily: 'MedievalSharp', color: Color(0xFFC8A971)),
          headlineSmall: const TextStyle(fontFamily: 'MedievalSharp', color: Color(0xFFC8A971)),
          titleLarge: const TextStyle(fontFamily: 'MedievalSharp', color: Color(0xFFC8A971)),
          titleMedium: const TextStyle(fontFamily: 'MedievalSharp', color: Color(0xFFC8A971)),
          titleSmall: const TextStyle(fontFamily: 'MedievalSharp', color: Color(0xFFC8A971)),
          bodyLarge: const TextStyle(fontFamily: 'Roboto', color: Color(0xFFF5F5F5)),
          bodyMedium: const TextStyle(fontFamily: 'Roboto', color: Color(0xFFF5F5F5)),
          bodySmall: const TextStyle(fontFamily: 'Roboto', color: Color(0xFFCCCCCC)),
        ),
        dataTableTheme: DataTableThemeData(
          headingRowColor: WidgetStateProperty.all(const Color(0xFF8B0000)),
          headingTextStyle: const TextStyle(fontFamily: 'MedievalSharp', color: Color(0xFFF5F5F5), fontWeight: FontWeight.bold),
          dataRowColor: WidgetStateProperty.all(const Color(0xFF2c2c2c)),
          dataTextStyle: const TextStyle(fontFamily: 'Roboto', color: Color(0xFFF5F5F5)),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF2c2c2c),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC8A971)),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC8A971), width: 2),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          labelStyle: TextStyle(color: Color(0xFFC8A971)),
        ),
      ),
      home: HomeScreen(
        player: _player,
        isPlaying: _isPlaying,
        showMusicButton: _showOverlay,
        onStartMusic: _startAudioWeb,
        onVolumeChanged: (v) => _player.setVolume(v),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
