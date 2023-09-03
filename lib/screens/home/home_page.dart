// ignore_for_file: avoid_unnecessary_containers

import 'dart:math';

import 'package:flutter/material.dart';

// TODO: ใส่รหัสนักศึกษาที่ค่าสตริงนี้
const studentId = '630710340';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class Question {
  final String text;
  final List<Choice> choices;

  Question({
    required this.text,
    required this.choices,
  });
}

class Choice {
  final String text;
  final IconData? icon;
  final Color? color;

  Choice({
    required this.text,
    this.icon,
    this.color,
  });
}

final List<Question> questions = [
  Question(
    text: 'What is the capital of France?',
    choices: [
      Choice(text: 'London'),
      Choice(text: 'Berlin'),
      Choice(text: 'Paris', icon: Icons.check, color: Colors.green),
      Choice(text: 'Madrid'),
    ],
  ),
  Question(
    text: 'Which planet is known as the Red Planet?',
    choices: [
      Choice(text: 'Venus', icon: Icons.check, color: Colors.green),
      Choice(text: 'Mars'),
      Choice(text: 'Jupiter'),
      Choice(text: 'Saturn'),
    ],
  ),
  // Add more questions here
];

Question getRandomQuestion(List<Question> questions) {
  final random = Random();
  final index = random.nextInt(questions.length);
  return questions[index];
}

class _HomePageState extends State<HomePage> {
  late Question currentQuestion;
  int selectedChoiceIndex = -1;

  void initState() {
    super.initState();
    currentQuestion = getRandomQuestion(questions);
  }

  void handleChoiceSelected(int choiceIndex) {
    setState(() {
      selectedChoiceIndex = choiceIndex;
    });
  }

  void moveToNextQuestion() {
    if (questions.isNotEmpty) {
      final currentIndex = questions.indexOf(currentQuestion);
      if (currentIndex < questions.length - 1) {
        currentQuestion = questions[currentIndex + 1];
        selectedChoiceIndex = -1;
      } else {
        // Handle end of quiz
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('Quiz Completed'),
              content: Text('You have completed the quiz!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void moveToPreviousQuestion() {
    if (questions.isNotEmpty) {
      final currentIndex = questions.indexOf(currentQuestion);
      if (currentIndex > 0) {
        currentQuestion = questions[currentIndex - 1];
        selectedChoiceIndex = -1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_colorful.jpg"),
              opacity: 0.6,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Good Morning',
                  textAlign: TextAlign.center, style: textTheme.headlineMedium),
              Text(studentId,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black87)),
              SizedBox(width: 16.0, height: 40.0),
              Column(),
              _buildQuizView(),
              SizedBox(width: 16.0, height: 40.0),
              Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          _buildButtonPanel(Colors.red, Icons.arrow_back_ios,moveToPreviousQuestion),
                          _buildButtonPanel(Colors.teal, Icons.arrow_forward_ios,moveToNextQuestion),
                        ]),
                      )
                    ],
                  )),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  _buildQuizView() {
    return Expanded(
      child: Container(
        width: 50.0,
        height: 400.0,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black87, width: 2.0),
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 7,
                  blurRadius: 12,
                  offset: Offset(0, 10))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Text(
                  ' Question 1 of 30 ',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: 70.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                            color: Colors.teal.shade400,
                            border:
                            Border.all(color: Colors.black87, width: 2.0),
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 7,
                                  blurRadius: 12,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currentQuestion.text,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  currentQuestion.choices.asMap().entries.map((entry) {
                    final choiceIndex = entry.key;
                    final choiceText = entry.value;


                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 6.0),
                        decoration: BoxDecoration(
                          color: selectedChoiceIndex == choiceIndex
                              ? Colors.lightBlue
                              : Colors.white,
                          border: Border.all(color: Colors.black87, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            handleChoiceSelected(choiceIndex);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            elevation: 0,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                                children: [

                                ]
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildButtonPanel(Color color, IconData icon,Function() onPressed) {
    return Expanded(
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 100.0,
            height: 40.0,
            decoration: BoxDecoration(
                color: color,
                border: Border.all(color: Colors.black87, width: 2.0),
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 7,
                      blurRadius: 12,
                      offset: Offset(0, 10))
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(icon)],
            ),
          ),
        )
    );
  }
}