import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter1/screens/bottom_navigation_bar.dart';
import 'package:flutter1/screens/categories/categories_page.dart';
import 'package:flutter1/screens/constants.dart';
import 'home_screen_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    List<Widget> widgetOptions = <Widget>[
      HomeScreenContent(user: user), // Kullanıcıyı geçiyoruz
      const CategoriesPage(), // Kategoriler sayfasını buraya ekliyoruz
      Center(
        child: Text(
          'Arama Motoru', // Arama motoru metni
          style: TextStyle(color: AppColors.textColor),
        ),
      ), // Diğer sayfalar için örnek içerik
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Ana Sayfa', // Ana Sayfa başlığı
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
