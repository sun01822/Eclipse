import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class StoryTelling extends StatefulWidget {
  final String userName;
  final String selectedImage;

  const StoryTelling({
    Key? key,
    required this.userName,
    required this.selectedImage,
  }) : super(key: key);

  @override
  _StoryTellingState createState() => _StoryTellingState();
}

class _StoryTellingState extends State<StoryTelling> {
  List<String> lunaTexts = [
    'Luna: Do you know about Eclipse?',
    'Luna: Text 2',
    'Luna: Text 3',
    'Luna: Do you know about Eclipse?',
    'Luna: Text 2',
    'Luna: Text 3',
    'Luna: Text 2',
    'Luna: Text 3',
  ]; // Luna's dialogues

  List<String> userTexts = [
    'User: Yes, I do!',
    'User: Text 2',
    'User: Text 3',
    'Luna: Do you know about Eclipse?',
    'Luna: Text 2',
    'Luna: Text 3',
    'Luna: Text 2',
    'Luna: Text 3',
  ]; // User's responses

  int currentMessageIndex = 0; // Track the current message to display

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StoryTelling Page'),
      ),
      body: Padding(
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
            bottomRight: Radius.circular(0.0), // Adjust for user message
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
            bottomLeft: Radius.circular(0.0), // Adjust for Luna's message
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
              width: 50.0,
              height: 50.0,
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
            child: TyperAnimatedTextKit(
              text: [text],
              speed: const Duration(milliseconds: 50),
              textStyle: const TextStyle(
                fontSize: 16.0, // Adjust font size
                fontWeight: FontWeight.normal, // Adjust font weight
                color: Colors.white,
              ),
            ),
          ),
          if (isUserMessage)
            Image.asset(
              imageAsset,
              width: 50.0,
              height: 50.0,
              fit: BoxFit.scaleDown,
            ),
        ],
      ),
    );
  }
}
