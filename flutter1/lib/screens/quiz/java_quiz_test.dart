// lib/java_quiz_test.dart

import 'package:flutter/material.dart';
import 'dart:async';

class JavaQuizTest extends StatefulWidget {
  @override
  _JavaQuizTestState createState() => _JavaQuizTestState();
}

class _JavaQuizTestState extends State<JavaQuizTest> {
  int _secondsRemaining = 20;
  late Timer _timer;
  int _currentQuestionIndex = 0;
  String? _selectedOption;
  String? _correctAnswer;
  int _score = 0;
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Java hangi yıl piyasaya sürüldü?',
      'options': ['1995', '2000', '2005', '2010'],
      'answer': '1995',
    },
    {
      'question': 'Java\'nın yaratıcısı kimdir?',
      'options': [
        'James Gosling',
        'Guido van Rossum',
        'Bjarne Stroustrup',
        'Linus Torvalds'
      ],
      'answer': 'James Gosling',
    },
    {
      'question': 'Java\'da hangi veri tipi yoktur?',
      'options': ['int', 'char', 'float', 'string'],
      'answer': 'string',
    },
    {
      'question': 'Java\'da hangi anahtar kelime işlevseldir?',
      'options': ['def', 'function', 'class', 'method'],
      'answer': 'class',
    },
    {
      'question': 'Java\'da hangi kütüphane standarttır?',
      'options': ['java.util', 'java.io', 'java.net', 'java.awt'],
      'answer': 'java.util',
    },
  ];

  @override
  void initState() {
    super.initState();
    if (_questions.isNotEmpty) {
      _correctAnswer = _questions[_currentQuestionIndex]['answer'];
    }
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer.cancel();
        _handleOptionSelect(null);
      }
    });
  }

  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _secondsRemaining = 20;
    });
    _startCountdown();
  }

  void _nextQuestion() {
    setState(() {
      if (_questions.isNotEmpty) {
        _currentQuestionIndex = (_currentQuestionIndex + 1) % _questions.length;
        _selectedOption = null;
        _correctAnswer = _questions[_currentQuestionIndex]['answer'];
      }
    });
    _resetTimer();
  }

  void _handleOptionSelect(String? option) {
    if (option == null) {
      setState(() {
        _selectedOption = _correctAnswer;
      });
    } else {
      setState(() {
        _selectedOption = option;
        if (option == _correctAnswer) {
          _score++;
        }
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion =
        _questions.isNotEmpty ? _questions[_currentQuestionIndex] : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Java Quiz Test',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -50,
            left: MediaQuery.of(context).size.width / 2 - 207,
            child: Container(
              width: 414,
              height: 242,
              decoration: const BoxDecoration(
                color: Color(0xFF773BFF),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _getTimerColor(),
                shape: BoxShape.circle,
                border: Border.all(
                  color: _getTimerBorderColor(),
                  width: 5,
                ),
              ),
              child: Center(
                child: Text(
                  '${_secondsRemaining}s',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: MediaQuery.of(context).size.width / 2 - 179.5,
            child: Container(
              width: 359,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Soru ${_currentQuestionIndex + 1}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (currentQuestion != null) ...[
                    Text(
                      '${currentQuestion['question']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: currentQuestion['options']
                          .map<Widget>((option) => _buildOptionButton(option))
                          .toList(),
                    ),
                  ],
                  const SizedBox(height: 20),
                  if (_selectedOption != null) ...[
                    ElevatedButton(
                      onPressed: _nextQuestion,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF773BFF),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                      ),
                      child: const Text(
                        'Sonraki Soru',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Puan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '$_score',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF773BFF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(String option) {
    final isSelected = _selectedOption == option;
    final buttonColor = isSelected
        ? (option == _correctAnswer ? Colors.green : Colors.red)
        : Colors.white;
    final textColor = isSelected ? Colors.white : Colors.black;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed:
            _selectedOption == null ? () => _handleOptionSelect(option) : null,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: buttonColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        child: Container(
          width: double.infinity,
          child: Text(
            option,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Color _getTimerColor() {
    if (_secondsRemaining <= 5) {
      return Colors.red;
    }
    return Colors.green;
  }

  Color _getTimerBorderColor() {
    if (_secondsRemaining <= 5) {
      return Colors.red;
    }
    return Colors.green;
  }
}
