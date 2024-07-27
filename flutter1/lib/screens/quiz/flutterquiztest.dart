import 'package:flutter/material.dart';
import 'dart:async'; // Timer kullanmak için gerekli

class FlutterQuizTest extends StatefulWidget {
  @override
  _FlutterQuizTestState createState() => _FlutterQuizTestState();
}

class _FlutterQuizTestState extends State<FlutterQuizTest> {
  int _secondsRemaining = 20; // Başlangıç süresi 20 saniye
  late Timer _timer;
  int _currentQuestionIndex = 0;
  String? _selectedOption; // Kullanıcının seçtiği şık
  String? _correctAnswer; // Doğru yanıt
  int _score = 0; // Kullanıcının toplam puanı
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Flutter hangi dilde yazılmıştır?',
      'options': ['Kotlin', 'Swift', 'Java', 'Dart'],
      'answer': 'Dart',
    },
    {
      'question': 'Dart hangi firmaya aittir?',
      'options': ['Google', 'Apple', 'Microsoft', 'Amazon'],
      'answer': 'Google',
    },
    {
      'question': 'Flutter ne zaman ilk kez piyasaya sürüldü?',
      'options': ['2014', '2015', '2016', '2017'],
      'answer': '2017',
    },
    {
      'question': 'Flutter hangi tür uygulamalar geliştirmek için kullanılır?',
      'options': [
        'Web Uygulamaları',
        'Mobil Uygulamalar',
        'Masaüstü Uygulamalar',
        'Hepsi'
      ],
      'answer': 'Hepsi',
    },
    {
      'question': 'Hangi widget, Flutter’daki uygulama arayüzünü tanımlar?',
      'options': ['Container', 'MaterialApp', 'Scaffold', 'Text'],
      'answer': 'MaterialApp',
    },
    {
      'question': 'Flutter, hangi şirket tarafından desteklenmektedir?',
      'options': ['Google', 'Facebook', 'Microsoft', 'Apple'],
      'answer': 'Google',
    },
    // Daha fazla soru ekleyebilirsiniz...
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
        _timer.cancel(); // Timer'ı durdur
        _handleOptionSelect(null); // Zaman dolduğunda şık seçimini işleyin
      }
    });
  }

  void _resetTimer() {
    _timer.cancel(); // Mevcut zamanlayıcıyı durdur
    setState(() {
      _secondsRemaining = 20; // Zamanlayıcı süresini 20 saniyeye sıfırla
    });
    _startCountdown(); // Zamanlayıcıyı yeniden başlat
  }

  void _nextQuestion() {
    setState(() {
      if (_questions.isNotEmpty) {
        _currentQuestionIndex = (_currentQuestionIndex + 1) % _questions.length;
        _selectedOption = null; // Her yeni soruda seçimi sıfırla
        _correctAnswer = _questions[_currentQuestionIndex]['answer'];
      }
    });
    _resetTimer(); // Zamanlayıcıyı sıfırla ve başlat
  }

  void _handleOptionSelect(String? option) {
    if (option == null) {
      // Zaman dolduğunda yanıt verildi
      setState(() {
        _selectedOption =
            _correctAnswer; // Yanlış cevap veren seçenek olarak doğru cevabı göster
      });
    } else {
      setState(() {
        _selectedOption = option;
        if (option == _correctAnswer) {
          _score++; // Doğru cevap verildiğinde puanı artır
        }
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // Sayfa kapatıldığında Timer'ı durdur
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion =
        _questions.isNotEmpty ? _questions[_currentQuestionIndex] : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz Test',
          style: TextStyle(
            color: Colors.white, // Başlık rengi beyaz
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black, // Başlık çubuğu rengi
        iconTheme: const IconThemeData(
          color: Colors.white, // Geri butonu rengi beyaz
        ),
      ),
      backgroundColor: Colors.black, // Arka plan rengi
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -50, // Üstten 50 piksel kaydır
            left:
                MediaQuery.of(context).size.width / 2 - 207, // Ortaya yerleştir
            child: Container(
              width: 414,
              height: 242,
              decoration: const BoxDecoration(
                color: Color(0xFF773BFF), // Kutunun rengi mor
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20, // Üstten 20 piksel kaydır
            right: 20, // Sağdan 20 piksel kaydır
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _getTimerColor(), // Zamanlayıcı rengi
                shape: BoxShape.circle,
                border: Border.all(
                  color: _getTimerBorderColor(), // Kenarlık rengi
                  width: 5,
                ),
              ),
              child: Center(
                child: Text(
                  '${_secondsRemaining}s',
                  style: const TextStyle(
                    fontSize: 14, // Küçültülmüş font boyutu
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 120, // Üstten 120 piksel kaydır
            left: MediaQuery.of(context).size.width / 2 -
                179.5, // Ortaya yerleştir
            child: Container(
              width: 359,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white, // İçteki kutunun rengi beyaz
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
                  const SizedBox(
                      height: 20), // Soru numarası ile sorunun arasına boşluk
                  if (currentQuestion != null) ...[
                    Text(
                      '${currentQuestion['question']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                        height:
                            20), // Soru metni ile seçeneklerin arasına boşluk
                    Column(
                      children: [
                        ...currentQuestion['options']
                            .map((option) => _buildOptionButton(option))
                            .toList(),
                        const SizedBox(
                            height: 20), // Şıkların ve butonun arasına boşluk
                        ElevatedButton(
                          onPressed: _nextQuestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF773BFF), // Buton rengi mor
                            foregroundColor:
                                Colors.white, // Buton yazısı rengi beyaz
                            elevation: 5, // Buton gölgesi
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Buton kenarlarını yuvarlat
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 15), // Butonun iç padding'i
                          ),
                          child: const Text(
                            'Sonraki Soru',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20, // Ekranın altına 20 piksel mesafe
            left:
                MediaQuery.of(context).size.width / 2 - 80, // Ortaya yerleştir
            child: Container(
              width: 160,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Skor: $_score',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getTimerColor() {
    if (_secondsRemaining <= 5) {
      return Colors.red; // 5 saniye veya daha az sürede arka plan rengi kırmızı
    } else if (_secondsRemaining <= 10) {
      return Colors.orange; // 10-5 saniye arası arka plan rengi turuncu
    } else {
      return Colors.green; // 20-11 saniye arası arka plan rengi yeşil
    }
  }

  Color _getTimerBorderColor() {
    if (_secondsRemaining <= 5) {
      return Colors.red; // 5 saniye veya daha az sürede kenarlık rengi kırmızı
    } else if (_secondsRemaining <= 10) {
      return Colors.orange; // 10-5 saniye arası kenarlık rengi turuncu
    } else {
      return Colors.green; // 20-11 saniye arası kenarlık rengi yeşil
    }
  }

  Widget _buildOptionButton(String option) {
    final isSelected = _selectedOption == option;
    final isCorrect = option == _correctAnswer;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        width: 339,
        height: 71,
        child: OutlinedButton(
          onPressed: () => _handleOptionSelect(option),
          style: OutlinedButton.styleFrom(
            backgroundColor: isSelected
                ? (isCorrect
                    ? Colors.green
                    : Colors.red) // Doğruysa yeşil, yanlışsa kırmızı
                : Colors.white, // Varsayılan arka plan rengi
            side: const BorderSide(
              color: Color(0xFF773BFF), // Kenarlık rengi mor
              width: 2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10), // Buton kenarlarını yuvarlat
            ),
          ),
          child: Text(
            option,
            style: const TextStyle(
              fontSize: 16, // Tüm şıklar için aynı font boyutu
              fontWeight: FontWeight.bold,
              color: Colors.black, // Yazı rengi siyah
            ),
          ),
        ),
      ),
    );
  }
}
