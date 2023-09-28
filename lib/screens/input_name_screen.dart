import 'package:eclipse/screens/character_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import the lottie package

class InputNameScreen extends StatefulWidget {
  const InputNameScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InputNameScreenState createState() => _InputNameScreenState();
}

class _InputNameScreenState extends State<InputNameScreen> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Name Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Lottie.asset( // Use Lottie.asset to load the animation from a JSON file
                'welcome.json', // Replace with your Lottie animation file path
                width: 400, // Set the width of the animation
                height: 400, // Set the height of the animation
                fit: BoxFit.cover, // Adjust the fit as needed
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Your Name',
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  String userName = nameController.text;
                  if (userName.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterSelectionScreen(userName: userName),
                      ),
                    );
                  }
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
