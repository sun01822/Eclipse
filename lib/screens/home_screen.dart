import 'package:eclipse/screens/pages/about_us.dart';
import 'package:eclipse/screens/pages/game.dart';
import 'package:eclipse/screens/pages/quiz_game.dart';
import 'package:eclipse/screens/pages/story_telling.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  final String selectedImage;

  // Add static variables to access the name and selected image
  static String homeScreenName = "";
  static String homeScreenSelectedImage = "";

  // Modify the constructor to initialize userName and selectedImage
  HomeScreen({
    Key? key,
    required this.selectedImage,
    required this.userName,
  }) : super(key: key) {
    // Initialize the static variables with the data received in the constructor
    HomeScreen.homeScreenName = userName;
    HomeScreen.homeScreenSelectedImage = selectedImage;
  }

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
   // Update the static variables with the data

  final List<Widget> _pages = [
    StoryTelling(
      userName: HomeScreen.homeScreenName, // Use the static variable
      selectedImage:
          HomeScreen.homeScreenSelectedImage, // Use the static variable
    ),
    const QuizGame(),
    const Game(),
    const AboutUs(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTabTapped,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      iconSize: 32,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.book_sharp),
          label: 'Story',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.quiz),
          label: 'Quiz',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.games_sharp),
          label: 'Game',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'About',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
