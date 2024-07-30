import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'articles_detail_screen.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  List<List<dynamic>> data = [];
  List<Map<String, String>> articles = [];

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  Future<void> _loadArticles() async {
    final rawData = await rootBundle.loadString('assets/articles/articles.csv');
    List<List<dynamic>> csvData = const CsvToListConverter().convert(rawData);

    // Skip the header row
    final List<Map<String, String>> fetchedArticles = [];
    for (int i = 1; i < csvData.length; i++) {
      final title = csvData[i][0];
      final content = csvData[i][1];
      fetchedArticles.add({'title': title, 'content': content});
    }

    setState(() {
      articles = fetchedArticles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Makaleler",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () {
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
                  child: Text(
                    article['title'] ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
