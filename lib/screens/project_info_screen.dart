import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:eclipse/data/slider_item.dart';
import 'package:eclipse/screens/input_name_screen.dart';

class ProjectInfoScreen extends StatefulWidget {
  const ProjectInfoScreen({Key? key}) : super(key: key);

  @override
  _ProjectInfoScreenState createState() => _ProjectInfoScreenState();
}

class _ProjectInfoScreenState extends State<ProjectInfoScreen> {
  int selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    int pageLength = items.length;

    // Get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height:
                      screenHeight * 0.4, // Set a percentage of screen height
                  autoPlay: true,
                  enlargeCenterPage: false,
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
                              width: screenWidth *
                                  0.5, // Set a percentage of screen width
                              height:
                                  screenWidth * 0.5, // Maintain aspect ratio
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
