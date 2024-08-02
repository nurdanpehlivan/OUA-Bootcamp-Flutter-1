import 'package:flutter/material.dart';
import 'package:flutter1/screens/quiz/java_quiz/java_quiz_test.dart'; // Yeni sayfanın import edilmesi

class JavaQuizGiris extends StatelessWidget {
  const JavaQuizGiris({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Java Quiz',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Sora",
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
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
                    Colors.red[300]!,
                    Colors.red[100]!
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
                  'assets/quiz_logo/java.png', // Java için uygun bir asset resmi
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
                    builder: (context) =>
                        JavaQuizTest(), // JavaQuizTest ekranına yönlendirme
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF773BFF), // Buton rengi mor
                foregroundColor: Colors.white, // Buton yazısı rengi beyaz
                elevation: 5, // Buton gölgesi
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Buton kenarlarını yuvarlat
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 15), // Butonun iç padding'i
              ),
              child: const Text(
                'Test\'e Başla',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20, // Yazı boyutunu ayarlayabilirsiniz
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
