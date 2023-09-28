import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String selectedImage;

  const HomeScreen({super.key, required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Home Screen!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Image.asset(
              selectedImage,
              width: 200.0,
              height: 200.0,
              fit: BoxFit.cover,
            ),
            // Add other content for your home screen here
          ],
        ),
      ),
    );
  }
}
