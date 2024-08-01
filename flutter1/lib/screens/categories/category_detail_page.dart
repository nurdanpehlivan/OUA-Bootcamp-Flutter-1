import 'package:flutter/material.dart';

class CategoryDetailPage extends StatelessWidget {
  const CategoryDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String category = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Kategori: $category',
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
