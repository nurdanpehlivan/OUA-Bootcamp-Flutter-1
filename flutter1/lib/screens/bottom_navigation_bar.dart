import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
          icon: Icon(Icons.favorite),
          label: 'Favoriler',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Ara',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.black,
      onTap: onTap,
    );
  }
}
