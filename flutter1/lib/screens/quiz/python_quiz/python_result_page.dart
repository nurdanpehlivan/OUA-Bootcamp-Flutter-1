import 'package:flutter/material.dart';

class PythonResultPage extends StatelessWidget {
  final int totalCorrectAnswers;
  final int totalIncorrectAnswers;

  const PythonResultPage({
    super.key,
    required this.totalCorrectAnswers,
    required this.totalIncorrectAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sonuçlar'),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Quiz Sonuçları',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Doğru Cevaplar: $totalCorrectAnswers',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Yanlış Cevaplar: $totalIncorrectAnswers',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF773BFF),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('Geri Dön'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
