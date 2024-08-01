import 'package:flutter/material.dart';
import '../quiz/flutter_quiz/flutterquiz_giris.dart';
import '../quiz/java_quiz/javaquiz_giris.dart';
import '../quiz/python_quiz/pythonquiz_giris.dart';
import '../quiz/cpp_quiz/cpp_quiz_giris.dart';
import '../quiz/kotlin_quiz/kotlin_quiz_giris.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Yazılım Dilleri',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Sora",
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: GridView.count(
        crossAxisCount: 2, // Her satırda 2 sütun gösterilecek
        padding: const EdgeInsets.all(16.0),
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: [
          CategoryCard(
            title: 'Flutter',
            imageUrl:
                'assets/quiz_logo/flutter.png', // Flutter için uygun bir asset resmi
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FlutterPage(),
                ),
              );
            },
          ),
          CategoryCard(
            title: 'Python',
            imageUrl:
                'assets/quiz_logo/python.png', // Python için uygun bir asset resmi
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PythonQuizGiris(),
                ),
              );
            },
          ),
          CategoryCard(
            title: 'Java',
            imageUrl:
                'assets/quiz_logo/java.png', // Java için uygun bir asset resmi
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const JavaQuizGiris(),
                ),
              );
            },
          ),
          CategoryCard(
            title: 'C++',
            imageUrl:
                'assets/quiz_logo/cpp.png', // C++ için uygun bir asset resmi
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CppQuizGiris(),
                ),
              );
            },
          ),
          CategoryCard(
            title: 'Kotlin',
            imageUrl:
                'assets/quiz_logo/kotlin.jpg', // Kotlin için uygun bir asset resmi
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const KotlinQuizGiris(),
                ),
              );
            },
          ),
          // Diğer yazılım dilleri buraya eklenebilir
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const CategoryCard({
    required this.title,
    required this.imageUrl,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image.asset(
                imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
