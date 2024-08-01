import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter1/screens/constants.dart';
import '../quiz/pythonquiz_giris.dart'; // Python sayfasının import edilmesi
import 'package:flutter1/screens/quiz/javaquiz_giris.dart'; // Java sayfasının import edilmesi
import '../articles/articles_detail_screen.dart';
import '../articles/articles_screen.dart';

class HomeScreenContent extends StatefulWidget {
  final User? user;

  const HomeScreenContent({super.key, this.user});

  @override
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  List<List<dynamic>> csvData = [];
  List<Map<String, String>> articles = [];

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  Future<void> _loadArticles() async {
    final rawData = await rootBundle.loadString('assets/articles/articles.csv');
    List<List<dynamic>> data = const CsvToListConverter().convert(rawData);

    // Skip the header row and take the first two rows
    final List<Map<String, String>> fetchedArticles = [];
    for (int i = 1; i <= 2 && i < data.length; i++) {
      final title = data[i][0];
      final content = data[i][1];
      fetchedArticles.add({'title': title, 'content': content});
    }

    setState(() {
      articles = fetchedArticles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding),
            child: Text(
              'Hoşgeldin, ${widget.user?.displayName ?? 'Kullanıcı'}!',
              style: const TextStyle(
                fontSize: 24,
                color: AppColors.textColor,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.spacing),
          _buildArticlesSection(context),
          const SizedBox(height: AppDimensions.spacing),
          _buildProgrammingLanguagesSection(context),
        ],
      ),
    );
  }

  Widget _buildArticlesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.padding),
          child: Text(
            'Makaleler',
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Sora",
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.smallSpacing),
        SizedBox(
          height: 100,
          child: Stack(
            children: [
              ListView(
                scrollDirection: Axis.horizontal,
                children: articles.map((article) {
                  return _buildArticleCard(
                    article['title'] ?? '',
                    context,
                  );
                }).toList(),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.padding),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ArticlesPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.inputFillColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 12.0),
                    ),
                    child: const Text(
                      'Daha Fazla',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Sora",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildArticleCard(String title, BuildContext context) {
    return GestureDetector(
      onTap: () {
        final article =
            articles.firstWhere((article) => article['title'] == title);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailPage(
              title: article['title'] ?? '',
              content: article['content'] ?? '',
            ),
          ),
        );
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(left: AppDimensions.padding),
        padding: const EdgeInsets.all(AppDimensions.padding),
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgrammingLanguagesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.padding),
          child: Text(
            'Yazılım Dilleri',
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Sora",
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.smallSpacing),
        _buildLanguageCard('Flutter', 'assets/flutter_logo.png', context),
        _buildLanguageCard('Python', 'assets/python_logo.png', context),
        _buildLanguageCard('Java', 'assets/java_logo.jpg', context),
      ],
    );
  }

  Widget _buildLanguageCard(
      String name, String logoPath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('$name yazısına tıklandı'); // Tıklama olayını konsolda gör
        if (name == 'Flutter') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FlutterPage()),
          );
        } else if (name == 'Python') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PythonQuizGiris()), // Python sayfasına yönlendirme
          );
        } else if (name == 'Java') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    JavaQuizGiris()), // Java sayfasına yönlendirme
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.padding,
            vertical: AppDimensions.smallSpacing),
        padding: const EdgeInsets.all(AppDimensions.padding),
        decoration: BoxDecoration(
          color: AppColors.inputFillColor,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(logoPath, width: 40, height: 40),
            const SizedBox(width: AppDimensions.smallSpacing),
            Text(name,
                style:
                    const TextStyle(color: AppColors.textColor, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
