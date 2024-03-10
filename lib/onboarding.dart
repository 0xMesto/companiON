import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'signup.dart';
import 'signin.dart';

void main() {
  runApp(const Onboarding());
}

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Onboardingscreen(),
    );
  }
}

class Onboardingscreen extends StatefulWidget {
  const Onboardingscreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<Onboardingscreen> {
  final List<String> _images = [
    'assets/slide1.jpg',
    'assets/slide2.jpg',
    'assets/slide3.jpg',
  ];
  Timer? _timer;
  int _currentIndex = 0;
  int _nextIndex = 1;
  double _currentOpacity = 1.0;
  double _nextOpacity = 0.0;
  bool _isSplashVisible = true;

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentOpacity = 0.0;
        _nextOpacity = 1.0;
      });

      Future.delayed(const Duration(milliseconds: 1), () {
        setState(() {
          _currentIndex = _nextIndex;
          _nextIndex = (_nextIndex + 1) % _images.length;
          _currentOpacity = 1.0;
          _nextOpacity = 0.0;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isSplashVisible = false;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var imagePath in _images) {
        precacheImage(AssetImage(imagePath), context);
      }
      _startAutoPlay();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isSplashVisible) {
      return Scaffold(
        body: Center(
          child: Image.asset('assets/logo1.png', width: 300, height: 300),
        ),
      );
    } else {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            // Background images and opacity animations
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: _currentOpacity,
                duration: const Duration(milliseconds: 8000),
                child: Image.asset(
                  _images[_currentIndex],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: _nextOpacity,
                duration: const Duration(milliseconds: 3000),
                child: Image.asset(
                  _images[_nextIndex],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Logo and 'Connect Spontaneously' text
            Positioned(
              top: MediaQuery.of(context).padding.top + 20,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo1.png',
                    width: 300,
                    height: 140,
                  ),
                  Text(
                    'Connect Spontaneously',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width > 600 ? 35 : 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 'Join Us' button
            Positioned(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              bottom: 150,
              child: ElevatedButton(
                onPressed: () {
                  // Use Navigator to push to the signUp screen
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SignUp()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7F50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 60),
                  elevation: 0,
                  splashFactory: InkSplash.splashFactory,
                ),
                child: const Text(
                  'Join Us!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // 'Already have an account? Log in' text
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SignIn()));
                },
                child: const Text(
                  'Already have an account? Log in',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            // 'Preview' button
            Positioned(
              right: 20,
              top: MediaQuery.of(context).padding.top + 5,
              child: ElevatedButton(
                onPressed: () {
                  // Define the action for the 'Preview' button
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                child: const Text(
                  'Preview',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Version text
            const Positioned(
              left: 0,
              right: 0,
              bottom: 25,
              child: Text(
                'companiON version 2024.01.24.1927',
                style: TextStyle(
                  color: Color(0xFFFFFDD0),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}