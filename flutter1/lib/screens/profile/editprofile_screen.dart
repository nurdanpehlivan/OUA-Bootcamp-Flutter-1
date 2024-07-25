import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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

        // Telefon numarası ve doğum tarihi güncellenmediği için, buraya eklemek gerekebilir
        // Bu genellikle bir veritabanı güncellemesi gerektirir

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
      appBar: AppBar(
        title: const Text('Profili Düzenle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                const SizedBox(height: 16),
                // Cinsiyet seçimi
                DropdownButtonFormField<String>(
                  value: _gender,
                  decoration: const InputDecoration(labelText: 'Cinsiyet'),
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
                const SizedBox(height: 16),
                // Doğum tarihi seçimi
                TextFormField(
                  controller: _birthDateController,
                  decoration: const InputDecoration(labelText: 'Doğum Tarihi'),
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
                const SizedBox(height: 16),
                // Telefon numarası girişi
                IntlPhoneField(
                  controller: _phoneController,
                  decoration:
                      const InputDecoration(labelText: 'Telefon Numarası'),
                  initialCountryCode: 'TR',
                  validator: (value) {
                    if (value == null || value.number.isEmpty) {
                      return 'Telefon numarasını girin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                // Güncelle butonu
                ElevatedButton(
                  onPressed: _updateProfile,
                  child: const Text('Güncelle'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
