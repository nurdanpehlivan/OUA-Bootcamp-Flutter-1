import 'package:flutter/material.dart';
import 'package:flutter1/screens/constants.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

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
          icon: Icon(Icons.search),
          label: 'Arama Motoru', // Arama motoru etiketi
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: AppColors.buttonColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: AppColors.backgroundColor,
      onTap: onItemTapped,
    );
  }
}
