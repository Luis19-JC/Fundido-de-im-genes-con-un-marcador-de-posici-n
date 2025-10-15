import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'dart:typed_data';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final http.Response response = await http.get(
    Uri.parse(
      'https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExamVwOWh2eGZsMWgwb2I3M2J0ZHE0NTk4Y2huNmU1OGRjYTJreXN4eiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ppSjX2iP9Ec1ExJRsV/giphy.gif',
    ),
  );
  final Uint8List bytes = response.bodyBytes;
  runApp(MyAppWithSplash(placeholderBytes: bytes));
}

// ===========================================
// APP CON SPLASH
// ===========================================
class MyAppWithSplash extends StatelessWidget {
  final Uint8List placeholderBytes;
  const MyAppWithSplash({super.key, required this.placeholderBytes});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fade App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(placeholderBytes: placeholderBytes),
    );
  }
}

// ===========================================
// SPLASH SCREEN
// ===========================================
class SplashScreen extends StatefulWidget {
  final Uint8List placeholderBytes;
  const SplashScreen({super.key, required this.placeholderBytes});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool _showLogo = true;
  late final AnimationController _lottieController;

  @override
  void initState() {
    super.initState();

    _lottieController = AnimationController(vsync: this);

    // Logo 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showLogo = false;
      });
      _lottieController.forward();
    });
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        149,
        147,
        155,
      ), // fondo morado claro
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Lottie animación
          Lottie.asset(
            'assets/VibeCity_splash.json',
            controller: _lottieController,
            width: 500,
            height: 500,
            onLoaded: (composition) {
              _lottieController.duration = composition.duration;
              _lottieController.addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) =>
                          HomePage(placeholderBytes: widget.placeholderBytes),
                    ),
                  );
                }
              });
            },
          ),

          // Logo encima con fade
          AnimatedOpacity(
            opacity: _showLogo ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              color: Colors.white,
              child: Center(
                child: Image.asset('assets/halo_logo.png', width: 200),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================
// HOME PAGE CON FADEINIMAGE
// ===========================================
class HomePage extends StatelessWidget {
  final Uint8List placeholderBytes;
  const HomePage({super.key, required this.placeholderBytes});

  @override
  Widget build(BuildContext context) {
    const title = 'Fade in images';

    return Scaffold(
      appBar: AppBar(title: const Text(title)),
      body: Center(
        child: FadeInImage.memoryNetwork(
          placeholder: placeholderBytes,
          image:
              'https://i.pinimg.com/736x/97/2c/d8/972cd8f3adbabe3fbf63ec472a42a087.jpg',
        ),
      ),
    );
  }
}
