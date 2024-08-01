import 'package:flutter/material.dart';
import 'package:flutter1/screens/quiz/java_quiz_test.dart'; // Yeni sayfanın import edilmesi

class JavaQuizGiris extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Java Quiz'),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JavaQuizTest()), // Java quiz testine yönlendirme
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF773BFF),
            foregroundColor: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: const Text(
            'Başla',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class FlutterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Sayfası',
          style: TextStyle(
            color: Colors.white, // Başlık rengi beyaz
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black, // Başlık çubuğu rengi
        iconTheme: IconThemeData(
          color: Colors.white, // Geri butonu rengi beyaz
        ),
      ),
      backgroundColor: Colors.black, // Arka plan rengi
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
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  'assets/Flutter.png', // Resim yolu
                  fit: BoxFit.cover, // Resmin kapsama şeklini ayarlar
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Butona tıklama işlemi gerçekleştirilir ve yeni ekran açılır
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          JavaQuizTest()), // FlutterQuizTest ekranına yönlendirme
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF773BFF), // Buton rengi mor
                foregroundColor: Colors.white, // Buton yazısı rengi beyaz
                elevation: 5, // Buton gölgesi
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Buton kenarlarını yuvarlat
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 30, vertical: 15), // Butonun iç padding'i
              ),
              child: Text(
                'Butona Tıkla',
                style: TextStyle(
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

void main() {
  runApp(MaterialApp(
    home: FlutterPage(),
  ));
}
