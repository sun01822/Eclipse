import 'package:carousel_slider/carousel_slider.dart';
import 'package:eclipse/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

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
  int selectedImageIndex = 0; // Initialize with no selection
  CarouselController controller = CarouselController();

  final List<String> imagePaths = [
    'assets/image1.png',
    'assets/image2.png',
    'assets/image3.png',
    'assets/image4.png',
  ];

  @override
  Widget build(BuildContext context) {
    int pageLength = imagePaths.length;

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
            CarouselSlider(
              carouselController: controller,
              items: imagePaths.map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: 250.0,
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedImageIndex ==
                                  imagePaths.indexOf(imagePath)
                              ? Colors.blue
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Image.asset(
                        imagePath,
                        width: 240.0,
                        height: 240.0,
                        fit: BoxFit.scaleDown,
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 250.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    selectedImageIndex = index;
                  });
                },
                // Customize the appearance of the dots
                viewportFraction: 1,
                aspectRatio: 2.0,
                autoPlay: false,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                scrollDirection: Axis.horizontal,
              ),
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
                color:
                    Colors.grey, // Set the color of inactive dots (e.g., grey)
                activeColor: Colors
                    .orange, // Set the color of the selected (active) dot to orange
              ),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                if (selectedImageIndex >= 0 &&
                    selectedImageIndex < imagePaths.length) {
                  String selectedImage = imagePaths[selectedImageIndex];
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                          selectedImage: selectedImage,
                          userName: widget.userName), // Pass userName here
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
