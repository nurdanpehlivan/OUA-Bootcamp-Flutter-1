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
    return Theme(
      data: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedLabelStyle: TextStyle(
            fontFamily: 'Sora', // Use new font here
            fontWeight: FontWeight.w600, // Adjust weight
            fontSize: 14.0, // Adjust size as needed
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Sora', // Use new font here
            fontWeight: FontWeight.w400, // Regular weight
            fontSize: 12.0, // Adjust size as needed
          ),
        ),
      ),
      child: BottomNavigationBar(
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
            label: 'Arama Motoru',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: AppColors.buttonColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: AppColors.backgroundColor,
        onTap: onItemTapped,
      ),
    );
  }
}
