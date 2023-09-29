import 'dart:async';
import 'dart:math'; // Import the dart:math library
import 'package:eclipse/data/eclipse_questions.dart';
import 'package:eclipse/models/questions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class QuizGame extends StatefulWidget {
  const QuizGame({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _QuizGameState createState() => _QuizGameState();
}

class _QuizGameState extends State<QuizGame> {
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  int remainingTime = 180; // 3 minutes in seconds
  late final ValueNotifier<int> timerNotifier;
  late final ValueNotifier<bool> quizCompletedNotifier;

  late List<Question> shuffledQuestions; // Store shuffled questions
  static const int numberOfQuestionsToShow = 5;

  @override
  void initState() {
    super.initState();
    timerNotifier = ValueNotifier<int>(remainingTime);
    quizCompletedNotifier = ValueNotifier<bool>(false);

    // Shuffle the list of questions
    final random = Random();
    shuffledQuestions = List.from(eclipseQuestions); // Make a copy
    shuffledQuestions.shuffle(random);

    // Ensure only 15 questions are displayed
    shuffledQuestions = shuffledQuestions.sublist(0, numberOfQuestionsToShow);

    startTimer();
  }

  void startTimer() {
    const Duration interval = Duration(seconds: 1);
    Timer.periodic(interval, (Timer timer) {
      if (remainingTime == 0) {
        timer.cancel();
        quizCompletedNotifier.value = true;
        showResultDialog();
      } else {
        remainingTime--;
        timerNotifier.value = remainingTime;
      }
    });
  }

  void checkAnswer(int selectedOptionIndex) {
    if (selectedOptionIndex ==
        shuffledQuestions[currentQuestionIndex].correctOptionIndex) {
      setState(() {
        correctAnswers++;
      });
    }
    nextQuestion();
  }

  void nextQuestion() {
    if (currentQuestionIndex < 14) {
      // Display the first 15 questions
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      quizCompletedNotifier.value = true;
      showResultDialog();
    }
  }

  void showResultDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Quiz Completed'),
          content: Text(
              'You got $correctAnswers out of ${shuffledQuestions.length} correct!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                resetQuiz();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      correctAnswers = 0;
      remainingTime = 600;
      final random = Random();
      shuffledQuestions.shuffle(random); // Shuffle questions again
      quizCompletedNotifier.value = false;
    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ValueListenableBuilder<int>(
              valueListenable: timerNotifier,
              builder: (context, time, child) {
                final minutes = (time / 60).floor();
                final seconds = time % 60;
                return Row(
                  children: [
                    const Icon(Icons.access_time),
                    Text('$minutes:$seconds'),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Lottie Animation as Background
          Positioned.fill(
            child: Lottie.asset(
              'assets/storybg.json', // Replace with the actual path to your Lottie animation JSON file
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Question ${currentQuestionIndex + 1}/${shuffledQuestions.length}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      shuffledQuestions[currentQuestionIndex].text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...shuffledQuestions[currentQuestionIndex]
                      .options
                      .asMap()
                      .entries
                      .map(
                    (entry) {
                      final index = entry.key;
                      final option = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: ElevatedButton(
                          onPressed: quizCompletedNotifier.value
                              ? null
                              : () => checkAnswer(index),
                          child: Text(option),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timerNotifier.dispose();
    quizCompletedNotifier.dispose();
    super.dispose();
  }
}
