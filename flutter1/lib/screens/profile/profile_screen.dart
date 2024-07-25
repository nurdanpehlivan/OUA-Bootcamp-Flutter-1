import 'package:flutter/material.dart';
import 'package:flutter1/screens/profile/more_options_box.dart';
import 'package:flutter1/screens/profile/profile_box.dart';
import 'package:flutter1/screens/profile/settings_box.dart';

class ProfileScreen extends StatelessWidget {
  final Function(String) onLanguageChange;

  const ProfileScreen({super.key, required this.onLanguageChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Profil',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ProfileBox(),
            const SizedBox(height: 8),
            const Text(
              'Ayarlar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SettingsBox(onLanguageChange: onLanguageChange),
            const SizedBox(height: 8),
            const Text(
              'Daha Fazla',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const MoreOptionsBox(),
          ],
        ),
      ),
    );
  }
}
