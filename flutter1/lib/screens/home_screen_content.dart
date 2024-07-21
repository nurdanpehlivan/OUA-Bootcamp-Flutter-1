import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  Future<String> _getImageUrl(String imageName) async {
    final ref = FirebaseStorage.instance.ref().child('logos/$imageName');
    return await ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hoşgeldin, ${user?.displayName ?? 'Kullanıcı'}!',
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Makaleler',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 10),
            ArticleCard(
              title: 'Örnek Makale',
              imageUrl: '',
              onTap: () {},
            ),
            const SizedBox(height: 20),
            const Text(
              'Yazılım Dilleri',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 10),
            FutureBuilder<String>(
              future: _getImageUrl('flutter_logo.png'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return LanguageCard(
                    title: 'Flutter',
                    imageUrl: snapshot.data!,
                    onTap: () {},
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            FutureBuilder<String>(
              future: _getImageUrl('python_logo.png'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return LanguageCard(
                    title: 'Python',
                    imageUrl: snapshot.data!,
                    onTap: () {},
                  );
                }
                return const CircularProgressIndicator();
              },
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
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Container(
                height: 100,
                width: double.infinity,
                color: Colors.grey, // Placeholder color
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const LanguageCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
