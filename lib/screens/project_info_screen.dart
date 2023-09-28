import 'package:eclipse/screens/input_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

class ProjectInfoScreen extends StatefulWidget {
  const ProjectInfoScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProjectInfoScreenState createState() => _ProjectInfoScreenState();
}

class _ProjectInfoScreenState extends State<ProjectInfoScreen> {
  int selectedImageIndex = 0; // Initialize with the first image
  final List<SliderItem> items = [
    SliderItem(
      imageAsset: 'assets/image1.png',
      headline: 'Problem Solving',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    SliderItem(
      imageAsset: 'assets/image2.png',
      headline: 'Innovation',
      description: 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
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
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const InputNameScreen()),
              );
            },
            child: const Text(
              'Skip',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 400.0,
              autoPlay: true,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  selectedImageIndex = index;
                });
              },
            ),
            items: items.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          item.imageAsset,
                          width: 200.0,
                          height: 200.0,
                          fit: BoxFit.scaleDown,
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
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20.0),
          // DotsIndicator widget to display dots
          DotsIndicator(
            dotsCount: pageLength,
            position: selectedImageIndex,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: Colors.grey, // Set the color of inactive dots (e.g., grey)
              activeColor: Colors.orange, // Set the color of the selected (active) dot to orange
            ),
          ),
        ],
      ),
    );
  }
}

class SliderItem {
  final String imageAsset;
  final String headline;
  final String description;

  SliderItem({
    required this.imageAsset,
    required this.headline,
    required this.description,
  });
}
