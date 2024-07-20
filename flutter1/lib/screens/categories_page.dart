import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategoriler'),
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
            title: 'Mobil Geliştirme',
            imageUrl: '',
            onTap: () {
              // Kategoriye tıklanınca yapılacak işlem
              Navigator.pushNamed(context, '/categoryDetail', arguments: 'Mobil Geliştirme');
            },
          ),
          CategoryCard(
            title: 'Web Geliştirme',
            imageUrl: '',
            onTap: () {
              Navigator.pushNamed(context, '/categoryDetail', arguments: 'Web Geliştirme');
            },
          ),
          CategoryCard(
            title: 'Veri Bilimi',
            imageUrl: '',
            onTap: () {
              Navigator.pushNamed(context, '/categoryDetail', arguments: 'Veri Bilimi');
            },
          ),
          CategoryCard(
            title: 'Yapay Zeka',
            imageUrl: '',
            onTap: () {
              Navigator.pushNamed(context, '/categoryDetail', arguments: 'Yapay Zeka');
            },
          ),
          // Diğer kategoriler buraya eklenebilir
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white24,
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
    );
  }
}
