import 'package:flutter/material.dart';

class KotlinResultPage extends StatelessWidget {
  final int totalCorrectAnswers;
  final int totalIncorrectAnswers;

  const KotlinResultPage({
    super.key,
    required this.totalCorrectAnswers,
    required this.totalIncorrectAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sonuçlar',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Toplam Doğru Cevap: $totalCorrectAnswers',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Toplam Yanlış Cevap: $totalIncorrectAnswers',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF773BFF),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text(
                'Geri Dön',
                style: TextStyle(
                  fontFamily: "Sora",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
