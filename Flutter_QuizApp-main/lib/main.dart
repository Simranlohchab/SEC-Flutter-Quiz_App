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
      title: 'Quiz App Simran_20221438',
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
      "question": "In a breadth-first search (BFS) traversal of a graph, which data structure is typically used?",
      "options": ["Stack", "Queue", "Array", "Linked List"],
      "answer": "Queue",
    },
    {
      "question": "What is the time complexity of binary search in a sorted array?"
      "options": ["O(1)", "O(log n)", "O(n)", "O(n^2)"],
      "answer": "O(log n)",
    },
    {
      "question": "What is the purpose of a hash table in data structures?",
      "options": ["Sorting elements", "Searching for an element", "Storing key-value pairs for efficient retrieval", " Implementing recursion"],
      "answer": "Storing key-value pairs for efficient retrieval",
    },
    {
      "question": "What is the time complexity of the quicksort algorithm in the average case?",
      "options": ["O(1)", "O(log n)", "O(n)", "O(n log n)"],
      "answer": "O(log n)",
    },
    {
      "question": "What is the main advantage of using a linked list over an array?",
      "options": ["Constant time access to elements", "Dynamic size", "Better cache locality", "Efficient for sorting"], 
      "answer": "Dynamic size",
    },
    {
      "question": "Which sorting algorithm has a quadratic time complexity in the worst case?",
      "options": ["QuickSort", "MergeSort", "BubbleSort", "InsertionSort"], 
      "answer": "BubbleSort",
    }
    {
      "question": "What is the purpose of a stack in data structures?",
      "options": ["Storing elements with constant time access", "Implementing recursion", "Searching for an element", "Efficiently retrieving the minimum element"], 
      "answer": "Implementing recursion",
    }
    {
      "question": "What is a binary tree?",
      "options": ["A tree where each node has more than two children", "A tree with exactly two children for each node", "A tree without any children", "A tree with arbitrary connections between nodes"], 
      "answer": "A tree with exactly two children for each node",
    }
    {
      "question": "What is the role of the "Big-O" notation in algorithm analysis?"
      "options": [" Representing the best-case scenario", "Representing the worst-case time complexity", "Describing the average-case time complexity", "Measuring the size of the input data"], 
      "answer": "Representing the worst-case time complexity",
    }
    {
      "question": "What is the purpose of dynamic programming in algorithms?"
      "options": ["Divide and conquer", "Memorization to avoid redundant computations", "Sorting elements", "Searching for an element"], 
      "answer": "Memorization to avoid redundant computations",
    }
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
