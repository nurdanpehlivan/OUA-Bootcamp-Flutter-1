import 'package:flutter/material.dart';
import 'package:flutter1/screens/profile/more_options_box.dart';
import 'package:flutter1/screens/profile/profile_box.dart';
import 'package:flutter1/screens/profile/settings_box.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon:  const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title:  const Text(
          'Profil',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: const Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             ProfileBox(),
             SizedBox(height: 8),
             Text(
              'Ayarlar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(height: 8),
             SettingsBox(), // Dil seçimi işlevini kaldırdık
             SizedBox(height: 8),
             Text(
              'Daha Fazla',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(height: 8),
             MoreOptionsBox(),
          ],
        ),
      ),
    );
  }
}
