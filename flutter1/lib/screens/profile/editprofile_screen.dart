import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../constants.dart'; // AppColors ve font ayarları için

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Initialize with current profile photo if needed
  }

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedImage;
    });
  }

  Future<void> _updateProfile() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null && _formKey.currentState?.validate() == true) {
      try {
        // Profil fotoğrafını yükleyin (varsa)
        String? photoURL;
        if (_image != null) {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('profile_pictures')
              .child('${user.uid}.jpg');
          await storageRef.putFile(File(_image!.path));
          photoURL = await storageRef.getDownloadURL();
        }

        // Kullanıcı bilgilerini güncelleyin
        await user.updateProfile(
          photoURL: photoURL,
        );

        await FirebaseAuth.instance.currentUser?.reload();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil güncellendi!')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Fotoğrafı Düzenle',
          style: TextStyle(fontFamily: "Sora", color: AppColors.textColor),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.padding),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profil fotoğrafı seçme
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: _image != null
                        ? FileImage(File(_image!.path))
                        : FirebaseAuth.instance.currentUser?.photoURL != null
                            ? NetworkImage(
                                FirebaseAuth.instance.currentUser!.photoURL!)
                            : const AssetImage('assets/profilfoto.png')
                                as ImageProvider,
                    child: _image == null
                        ? const Icon(Icons.camera_alt, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(
                    height: 20), // Profil fotoğrafı ile buton arasında boşluk
                // Güncelle butonu
                ElevatedButton(
                  onPressed: _updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.borderRadius),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                  ),
                  child: const Text(
                    'Güncelle',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Sora', fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
