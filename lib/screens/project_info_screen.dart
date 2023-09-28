import 'package:eclipse/screens/input_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProjectInfoScreen extends StatefulWidget {
  const ProjectInfoScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProjectInfoScreenState createState() => _ProjectInfoScreenState();
}

class _ProjectInfoScreenState extends State<ProjectInfoScreen> {
  final List<SliderItem> items = [
    SliderItem(
      imageAsset: 'image1.png',
      headline: 'Problem Solving',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    SliderItem(
      imageAsset: 'image2.png',
      headline: 'Innovation',
      description: 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
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
      body: CarouselSlider(
        options: CarouselOptions(
          height: 400.0,
          autoPlay: true,
          enlargeCenterPage: true,
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
                      fit: BoxFit.cover,
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
