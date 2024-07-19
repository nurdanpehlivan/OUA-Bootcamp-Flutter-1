import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ana Sayfa',
          style: TextStyle(color: Colors.white),
        ),
        
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Hoşgeldin, ${user?.displayName ?? 'Kullanıcı'}!',
                style: const TextStyle(fontSize: 24, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Makaleler',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ArticleCard(
                    title: 'Flutter ile Mobil Uygulama Geliştirmenin Avantajları',
                    imageUrl: 'https://example.com/flutter_image.jpg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ArticleScreen(
                            title: 'Flutter ile Mobil Uygulama Geliştirmenin Avantajları',
                            content: 'Burada makalenin tam metni olacak...',
                          ),
                        ),
                      );
                    },
                  ),
                  ArticleCard(
                    title: 'Backend Development for Beginners',
                    imageUrl: 'https://example.com/backend_image.jpg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ArticleScreen(
                            title: 'Backend Development for Beginners',
                            content: 'Burada makalenin tam metni olacak...',
                          ),
                        ),
                      );
                    },
                  ),
                  // Diğer makaleler buraya eklenebilir
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Yazılım Dilleri',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const Column(
              children: [
                LanguageCard(
                  language: 'Flutter',
                  imageUrl: 'https://example.com/flutter_logo.png',
                ),
                LanguageCard(
                  language: 'Python',
                  imageUrl: 'https://example.com/python_logo.png',
                ),
                LanguageCard(
                  language: 'Java',
                  imageUrl: 'https://example.com/java_logo.png',
                ),
                // Diğer yazılım dilleri buraya eklenebilir
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const ArticleCard({
    required this.title,
    required this.imageUrl,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: Colors.white24,
          child: SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(imageUrl, height: 120, fit: BoxFit.cover),
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
        ),
      ),
    );
  }
}

class LanguageCard extends StatelessWidget {
  final String language;
  final String imageUrl;

  const LanguageCard({
    required this.language,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        color: Colors.white24,
        child: ListTile(
          leading: Image.network(imageUrl, width: 50, height: 50),
          title: Text(language, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

class ArticleScreen extends StatelessWidget {
  final String title;
  final String content;

  const ArticleScreen({required this.title, required this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          content,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
