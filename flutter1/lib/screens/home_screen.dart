import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'categories_page.dart'; // Kategoriler sayfasını içe aktarın

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

    List<Widget> _widgetOptions = <Widget>[
      HomeScreenContent(user: user), // Kullanıcıyı geçiyoruz
      const CategoriesPage(), // Kategoriler sayfasını buraya ekleyin
      const Center(
          child: Text('Ayarlar Ekranı',
              style: TextStyle(
                  color: Colors.white))), // Diğer sayfalar için örnek içerik
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Kategoriler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  final User? user;

  const HomeScreenContent({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Hoşgeldin, ${user?.displayName ?? 'Kullanıcı'}!',
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
