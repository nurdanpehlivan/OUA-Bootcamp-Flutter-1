import 'package:flutter/material.dart';
import 'kotlin_quiz_test.dart'; // Kotlin quiz test sayfasının importu

class KotlinQuizGiris extends StatelessWidget {
  const KotlinQuizGiris({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kotlin Quiz',
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
          children: <Widget>[
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(20), // Kenarları 20 px yuvarlat
                gradient: LinearGradient(
                  colors: [
                    Colors.blue[300]!,
                    Colors.blue[100]!
                  ], // Kutu rengi için gradyan
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  'assets/quiz_logo/kotlin.jpg', // Resim yolu (Kotlin için uygun bir resim)
                  fit: BoxFit.cover, // Resmin kapsama şeklini ayarlar
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KotlinQuizTest(),
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
