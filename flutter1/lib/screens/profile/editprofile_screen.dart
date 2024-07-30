import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_database/firebase_database.dart'; // Realtime Database için ekledik
import '../constants.dart'; // AppColors ve font ayarları için

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _bioController =
      TextEditingController(); // Bio controller ekledik
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  String? _gender;

  @override
  void initState() {
    super.initState();
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _displayNameController.text = user.displayName ?? '';
      _phoneController.text =
          ''; // Profilde kayıtlı olan telefon numarası varsa buraya ekleyebilirsiniz
      _birthDateController.text =
          ''; // Profilde kayıtlı olan doğum tarihi varsa buraya ekleyebilirsiniz
      _bioController.text =
          ''; // Profilde kayıtlı olan bio varsa buraya ekleyebilirsiniz
    }
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
          displayName: _displayNameController.text,
          photoURL: photoURL,
        );

        // Bio bilgilerini Firestore'da güncelleyin
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'bio': _bioController.text,
        }, SetOptions(merge: true));

        // Diğer bilgileri Realtime Database'de güncelleyin
        final DatabaseReference dbRef =
            FirebaseDatabase.instance.ref().child('users').child(user.uid);
        await dbRef.set({
          'phone': _phoneController.text,
          'birthDate': _birthDateController.text,
          'gender': _gender,
        });

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
          'Profili Düzenle',
          style: TextStyle(fontFamily: "Sora", color: AppColors.textColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.padding),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Profil fotoğrafı seçme
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _image != null
                          ? FileImage(File(_image!.path))
                          : FirebaseAuth.instance.currentUser?.photoURL != null
                              ? NetworkImage(
                                  FirebaseAuth.instance.currentUser!.photoURL!)
                              : const AssetImage('assets/Avatar.png')
                                  as ImageProvider,
                      child: _image == null
                          ? const Icon(Icons.camera_alt, color: Colors.white)
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.smallSpacing),
                // Bio
                TextFormField(
                  controller: _bioController,
                  decoration: InputDecoration(
                    labelText: 'Bio',
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.blueGrey,
                      fontFamily: 'Sora',
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.borderRadius),
                      borderSide: const BorderSide(
                          color: Colors.white), // Çizgi rengi beyaz
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.borderRadius),
                      borderSide: const BorderSide(
                          color: Colors.white), // Çizgi rengi beyaz
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.borderRadius),
                      borderSide: const BorderSide(
                          color: Colors.white), // Çizgi rengi beyaz
                    ),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: AppDimensions.smallSpacing),
                // Cinsiyet seçimi
                DropdownButtonFormField<String>(
                  value: _gender,
                  decoration: InputDecoration(
                    labelText: 'Cinsiyet',
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.blueGrey,
                      fontFamily: 'Sora',
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.borderRadius),
                      borderSide: const BorderSide(
                          color: Colors.white), // Çizgi rengi beyaz
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.borderRadius),
                      borderSide: const BorderSide(
                          color: Colors.white), // Çizgi rengi beyaz
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.borderRadius),
                      borderSide: const BorderSide(
                          color: Colors.white), // Çizgi rengi beyaz
                    ),
                  ),
                  items: ['Kadın', 'Erkek']
                      .map((gender) => DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Cinsiyeti seçin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppDimensions.smallSpacing),
                // Doğum tarihi seçimi
                TextFormField(
                  controller: _birthDateController,
                  decoration: InputDecoration(
                    labelText: 'Doğum Tarihi',
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.blueGrey,
                      fontFamily: 'Sora',
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.borderRadius),
                      borderSide: const BorderSide(
                          color: Colors.white), // Çizgi rengi beyaz
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.borderRadius),
                      borderSide: const BorderSide(
                          color: Colors.white), // Çizgi rengi beyaz
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.borderRadius),
                      borderSide: const BorderSide(
                          color: Colors.white), // Çizgi rengi beyaz
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _birthDateController.text =
                            '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                      });
                    }
                  },
                ),
                const SizedBox(height: AppDimensions.smallSpacing),
                // Telefon numarası girişi
                IntlPhoneField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Telefon Numarası',
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.blueGrey,
                      fontFamily: 'Sora',
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.borderRadius),
                      borderSide: const BorderSide(
                          color: Colors.white), // Çizgi rengi beyaz
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.borderRadius),
                      borderSide: const BorderSide(
                          color: Colors.white), // Çizgi rengi beyaz
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.borderRadius),
                      borderSide: const BorderSide(
                          color: Colors.white), // Çizgi rengi beyaz
                    ),
                  ),
                  initialCountryCode: 'TR',
                  validator: (value) {
                    if (value == null || value.number.isEmpty) {
                      return 'Telefon numarasını girin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 200),
                // Güncelle butonu
                ElevatedButton(
                  onPressed: _updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.borderRadius),
                    ),
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
