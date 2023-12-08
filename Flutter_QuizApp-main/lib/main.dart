import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const primaryColor = Colors.teal;
const accentColor = Colors.teal;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App Ayush_20221462',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestion = -1; // Start with -1 to handle the initial start
  bool _quizEnded = false;
  int _score = 0;
  bool _quizStarted = false; // Track if the quiz has started

  final List<Map<String, dynamic>> _questions = [
    {
      "question": "Which operating system is developed by Apple Inc.??",
      "options": ["Android", "Windows", "Linux", "ios"],
      "answer": "ios",
    },
    {
      "question": "Visual Studio Code (VS Code) is developed by?",
      "options": ["Apple", "Google", "Microsoft", "Meta"],
      "answer": "Microsoft",
    },
    {
      "question": "Parent company of Google?",
      "options": ["Netflix", "Amazon", "Alphabet", "IBM"],
      "answer": "Alphabet",
    },
    {
      "question": "Who launched Unified Payments Interface (UPI)?",
      "options": [
        " Reserve Bank of India (RBI)",
        "National Payments Corporation of India (NPCI)",
        "Ministry of Finance",
        "State Bank of India (SBI)"
      ],
      "answer": " National Payments Corporation of India (NPCI)",
    },
    {
      "question": "India's first UPI-ATM was launched by?",
      "options": ["Google", "Jio", "Airtel", "Hitachi Payment Services"],
      "answer": "Hitachi Payment Services",
    },
  ];

  void _checkAnswer(String option) {
    if (_questions[_currentQuestion]["answer"] == option) {
      setState(() {
        _score++;
      });
    }
    _moveToNextQuestion();
  }

  void _moveToNextQuestion() {
    setState(() {
      _currentQuestion++;
      _quizEnded = _currentQuestion == _questions.length;
    });
  }

  void _moveToPreviousQuestion() {
    setState(() {
      if (_currentQuestion > 0) {
        _currentQuestion--;
        if (_quizEnded) {
          _score--; // Adjust the score
          _quizEnded = false;
        }
      }
    });
  }

  void _startQuiz() {
    setState(() {
      _currentQuestion = 0;
      _quizStarted = true;
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestion = -1;
      _quizEnded = false;
      _score = 0;
      _quizStarted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!_quizStarted ||
                      !_quizEnded) // Show only before quiz starts and if not ended
                    AnimatedOpacity(
                      opacity: _quizStarted ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        '\nWelcome to Quiz App!\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const SizedBox(height: 20.0),
                  if (_currentQuestion >= 0 && !_quizEnded)
                    Text(
                      "Question ${_currentQuestion + 1} of ${_questions.length}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  const SizedBox(height: 10.0),
                  if (_quizEnded)
                    Column(
                      children: [
                        Text(
                          "You have completed the quiz!",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Your final score is $_score out of ${_questions.length}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    )
                  else if (!_quizStarted)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        primary: primaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 40.0,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _startQuiz,
                      child: const Text("Start Quiz"),
                    )
                  else
                    Column(
                      children: [
                        Text(
                          _questions[_currentQuestion]["question"] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        ...(_questions[_currentQuestion]["options"]
                                as List<String>)
                            .map((option) => _optionButton(
                                  option,
                                  () {
                                    if (!_quizEnded) {
                                      _checkAnswer(option);
                                    }
                                  },
                                ))
                            .toList(),
                      ],
                    ),
                ],
              ),
            ),
          ),
          if (_quizEnded)
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: FloatingActionButton(
                backgroundColor: accentColor,
                onPressed: _resetQuiz,
                child: const Icon(Icons.refresh),
              ),
            ),
        ],
      ),
    );
  }

  Widget _optionButton(String option, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        minimumSize: const Size(double.infinity, 50.0),
        textStyle: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
      child: Text(option),
    );
  }
}
