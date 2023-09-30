import 'dart:async';
import 'package:eclipse/screens/project_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showText = false;

  @override
  void initState() {
    super.initState();

    // Load the splash screen for 1.5 seconds
    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        showText = true;
      });

      // Navigate to the next screen after 2 seconds
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/splash.gif",
            fit: BoxFit.cover, // Make the GIF full screen
            gaplessPlayback: true, // Prevent GIF repetition
          ),
          Center(
            child: AnimatedOpacity(
              opacity: showText ? 1.0 : 0.0,
              duration: const Duration(seconds: 2),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Eclipse",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Loading circle
                  SpinKitFadingCircle(
                    color: Colors.white, // Adjust the loading circle color
                    size: 50.0, // Adjust the loading circle size
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
