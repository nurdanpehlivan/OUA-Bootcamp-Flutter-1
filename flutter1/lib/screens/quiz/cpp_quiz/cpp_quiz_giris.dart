import 'package:flutter/material.dart';
import 'cpp_quiz_test.dart'; // C++ quiz test sayfasının importu

class CppQuizGiris extends StatelessWidget {
  const CppQuizGiris({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'C++ Quiz',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Sora",
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
          children: [
            // Logo ekleyin
            Image.asset(
              'assets/quiz_logo/cpp.png', // C++ logo için uygun bir asset yolu
              height: 150, // Logo yüksekliği
              width: 150, // Logo genişliği
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CppQuizTest(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF773BFF),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text(
                'Test\'e Başla',
                style: TextStyle(
                  fontFamily: "Sora",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
