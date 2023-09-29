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
  late List<String> lunaTexts;
  late List<String> userTexts;

  @override
  void initState() {
    super.initState();

    lunaTexts = [
      'Luna: Hi!! ${widget.userName}',
      'Luna: Do you know about Eclipse?',
      'The left and right padding for the message container have been adjusted to 10 while keeping the top and bottom padding as 20',
      'Luna: Text 3',
      'Luna: Text 2',
      'Luna: Text 3',
    ];

    userTexts = [
      'User: Hello!!',
      'User: Yes, I do!',
      'The left and right padding for the message container have been adjusted to 10 while keeping the top and bottom padding as 20',
      'Luna: Do you know about Eclipse?',
      'Luna: Text 2',
      'Luna: Text 3',
    ];

    // Start automatically displaying messages
    displayMessages(0);
  }

  int currentMessageIndex = 0;

  // Function to display messages automatically
  void displayMessages(int index) async {
    if (index < lunaTexts.length + userTexts.length) {
      // Delay before displaying the next message
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        currentMessageIndex = index;
      });

      // Determine the delay based on the length of the current message
      final currentMessage = (index % 2 == 0) ? lunaTexts[index ~/ 2] : userTexts[index ~/ 2];
      final wordsInCurrentMessage = currentMessage.split(' ').length;
      final delayInSeconds = wordsInCurrentMessage * 0.2; // Adjust the factor as needed

      // Delay after message display
      await Future.delayed(Duration(seconds: delayInSeconds.toInt() + 1));

      if (index == lunaTexts.length + userTexts.length - 1) {
        // If it's the last message, start from the beginning
        displayMessages(0);
      } else {
        displayMessages(index + 1); // Display the next message
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StoryTelling Page'),
      ),
      body: Stack(
        children: <Widget>[
          Lottie.asset(
            'assets/storybg.json',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(
                        currentMessageIndex + 1,
                        (index) {
                          final isUserMessage = index % 2 != 0;
                          final text = isUserMessage
                              ? userTexts[index ~/ 2]
                              : lunaTexts[index ~/ 2];

                          return MessageWidget(
                            isUserMessage: isUserMessage,
                            text: text,
                            imageAsset: isUserMessage
                                ? widget.selectedImage
                                : 'assets/luna.png',
                          );
                        },
                      ),
                    ),
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

    final screenWidth = MediaQuery.of(context).size.width;

    final imageSize = screenWidth > 600 ? 150.0 : 100.0;
    final fontSize = screenWidth > 600 ? 16.0 : 14.0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment:
            isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUserMessage)
            Image.asset(
              'assets/luna.png',
              width: imageSize,
              height: imageSize,
              fit: BoxFit.scaleDown,
            ),
          Align(
            alignment: isUserMessage
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
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
                isRepeatingAnimation: false,
                textStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (isUserMessage)
            Image.asset(
              imageAsset,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.scaleDown,
            ),
        ],
      ),
    );
  }
}
