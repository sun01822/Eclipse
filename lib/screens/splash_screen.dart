import 'dart:async';
import 'package:eclipse/screens/project_info_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late double opacity;
  late bool showText;

  @override
  void initState() {
    super.initState();
    opacity = 0.0;
    showText = false;

    Timer(const Duration(seconds: 1), () {
      setState(() {
        showText = true;
      });

      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ProjectInfoScreen(),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "splash.gif",
            fit: BoxFit.cover, // Make the GIF full screen
            gaplessPlayback: true, // Prevent GIF repetition
          ),
          AnimatedOpacity(
            opacity: showText ? 1.0 : 0.0,
            duration: const Duration(seconds: 2),
            child: const Center(
              child: Text(
                "Eclipse",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
          const Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
