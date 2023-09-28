import 'package:eclipse/screens/home_screen.dart';
import 'package:flutter/material.dart';

class CharacterSelectionScreen extends StatefulWidget {
  final String userName;

  const CharacterSelectionScreen({Key? key, required this.userName})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CharacterSelectionScreenState createState() =>
      _CharacterSelectionScreenState();
}

class _CharacterSelectionScreenState extends State<CharacterSelectionScreen> {
  int selectedImageIndex = -1; // Initialize with no selection

  final List<String> imagePaths = [
    'assets/image1.png',
    'assets/image2.png',
    'assets/image3.png',
    'assets/image4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Selection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Select an Image, ${widget.userName}',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImageIndex = index;
                    });
                  },
                  child: Container(
                    width: 150.0,
                    height: 150.0,
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedImageIndex == index
                            ? Colors.blue
                            : Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                    child: Image.asset(
                      imagePaths[index],
                      width: 150.0,
                      height: 150.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (selectedImageIndex >= 0 &&
                    selectedImageIndex < imagePaths.length) {
                  String selectedImage = imagePaths[selectedImageIndex];
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HomeScreen(selectedImage: selectedImage),
                    ),
                  );
                }
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
