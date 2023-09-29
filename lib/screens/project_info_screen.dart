import 'package:eclipse/screens/input_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:lottie/lottie.dart';

class ProjectInfoScreen extends StatefulWidget {
  const ProjectInfoScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProjectInfoScreenState createState() => _ProjectInfoScreenState();
}

class _ProjectInfoScreenState extends State<ProjectInfoScreen> {
  int selectedImageIndex = 0;
  final List<SliderItem> items = [
    SliderItem(
      animationAsset: 'assets/storytelling.json',
      headline: 'Story Telling',
      description: 'Luna will help you to know more about Eclipse',
    ),
    SliderItem(
      animationAsset: 'assets/quiz.json',
      headline: 'Quiz Game',
      description: 'You can check your knowledge about Eclipse',
    ),
    SliderItem(
      animationAsset: 'assets/game.json',
      headline: 'Eclipse Game',
      description: 'You can visualize Eclipse using this game',
    ),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    int pageLength = items.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Info Screen'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InputNameScreen(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.orange,
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                ),
              ),
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container( // Added a Container to wrap the CarouselSlider
              margin: const EdgeInsets.all(10.0), // Add margin around the entire slider
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 400.0,
                  autoPlay: true,
                  enlargeCenterPage: false, // Set to false
                  onPageChanged: (index, reason) {
                    setState(() {
                      selectedImageIndex = index;
                    });
                  },
                ),
                items: items.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Lottie.asset(
                              item.animationAsset,
                              width: 200.0,
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            item.headline,
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            item.description,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ],
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          DotsIndicator(
            dotsCount: pageLength,
            position: selectedImageIndex,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: Colors.grey,
              activeColor: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}

class SliderItem {
  final String animationAsset;
  final String headline;
  final String description;

  SliderItem({
    required this.animationAsset,
    required this.headline,
    required this.description,
  });
}
