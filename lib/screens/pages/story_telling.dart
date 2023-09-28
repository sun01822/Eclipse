import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart'; // Import Lottie package

class StoryTelling extends StatefulWidget {
  final String userName;
  final String selectedImage;

  const StoryTelling({
    Key? key,
    required this.userName,
    required this.selectedImage,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _StoryTellingState createState() => _StoryTellingState();
}

class _StoryTellingState extends State<StoryTelling> {
  late List<String> lunaTexts; // Declare lunaTexts as a field
  late List<String> userTexts; // Declare userTexts as a field
  
  @override
  void initState() {
    super.initState();

    // Initialize lunaTexts and userTexts using widget.userName
    lunaTexts = [
      'Luna: Hi!! ${widget.userName}', // Interpolate userName here
      'Luna: Do you know about Eclipse?',
      'Luna: Text 2',
      'Luna: Text 3',
      'Luna: Text 2',
      'Luna: Text 3',
      'Luna: Text 2',
      'Luna: Text 3',
    ];

    userTexts = [
      'User: Hello!!',
      'User: Yes, I do!',
      'User: Text 2',
      'User: Text 3',
      'Luna: Do you know about Eclipse?',
      'Luna: Text 2',
      'Luna: Text 3',
    ];
  }

  int currentMessageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StoryTelling Page'),
      ),
      body: Stack(
        children: <Widget>[
          // Display Lottie animation as a background
          Lottie.asset(
            'assets/storybg.json', // Replace with your Lottie file path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: currentMessageIndex + 1,
                    itemBuilder: (context, index) {
                      final isUserMessage = index % 2 != 0;
                      final text = isUserMessage
                          ? userTexts[index ~/ 2]
                          : lunaTexts[index ~/ 2];

                      return MessageWidget(
                        isUserMessage: isUserMessage,
                        text: text,
                        imageAsset: isUserMessage
                            ? widget.selectedImage
                            : 'luna.png',
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (currentMessageIndex <
                            lunaTexts.length + userTexts.length - 1) {
                          currentMessageIndex++;
                        }
                      });
                    },
                    child: const Text('Continue'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final bool isUserMessage;
  final String text;
  final String imageAsset;

  const MessageWidget({
    Key? key,
    required this.isUserMessage,
    required this.text,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = isUserMessage
        ? const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(0.0),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(15.0),
          );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment:
            isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUserMessage)
            Image.asset(
              'luna.png',
              width: 150.0,
              height: 150.0,
              fit: BoxFit.scaleDown,
            ),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: BoxDecoration(
              color: isUserMessage ? Colors.green : Colors.blue,
              borderRadius: borderRadius,
            ),
            padding: const EdgeInsets.all(10.0),
            // ignore: deprecated_member_use
            child: TyperAnimatedTextKit(
              text: [text],
              speed: const Duration(milliseconds: 50),
              textStyle: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          if (isUserMessage)
            Image.asset(
              imageAsset,
              width: 150.0,
              height: 150.0,
              fit: BoxFit.scaleDown,
            ),
        ],
      ),
    );
  }
}
