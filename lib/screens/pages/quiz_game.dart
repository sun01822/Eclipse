import 'dart:async';
import 'dart:math';
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

  late List<Question> shuffledQuestions; // Store shuffled questions
  static const int numberOfQuestionsToShow = 5;

  @override
  void initState() {
    super.initState();
    timerNotifier = ValueNotifier<int>(remainingTime);

    // Shuffle the list of questions
    final random = Random();
    shuffledQuestions = List.from(eclipseQuestions);
    shuffledQuestions.shuffle(random);

    // Ensure only 5 questions are displayed
    shuffledQuestions = shuffledQuestions.sublist(0, numberOfQuestionsToShow);

    startTimer();
  }

  void startTimer() {
    const Duration interval = Duration(seconds: 1);
    Timer.periodic(interval, (Timer timer) {
      if (remainingTime == 0) {
        timer.cancel();
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
    if (currentQuestionIndex < numberOfQuestionsToShow - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
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
              'You got $correctAnswers out of $numberOfQuestionsToShow correct!'),
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
      remainingTime = 180;
      final random = Random();
      shuffledQuestions.shuffle(random);
    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Wrap the Stack with Center
        child: Stack(
          children: [
            Positioned.fill(
              child: Lottie.asset(
                'assets/storybg.json',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ValueListenableBuilder<int>(
                    valueListenable: timerNotifier,
                    builder: (context, time, child) {
                      final minutes = (time / 60).floor();
                      final seconds = time % 60;
                      return Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // Center the clock
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Colors.white, // Set the clock icon color
                          ),
                          const SizedBox(
                              width:
                                  8), // Add some space between icon and timer
                          Text(
                            '$minutes:$seconds',
                            style: const TextStyle(
                                fontSize: 24, color: Colors.white),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Question ${currentQuestionIndex + 1}/$numberOfQuestionsToShow',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            shuffledQuestions[currentQuestionIndex].text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 24, color: Colors.white),
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
                                onPressed: () => checkAnswer(index),
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timerNotifier.dispose();
    super.dispose();
  }
}
