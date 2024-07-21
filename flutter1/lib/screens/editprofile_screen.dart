import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String selectedGender = 'Cinsiyet Seçiniz'; // Başlangıç değeri
  String _displayName = 'Nurdan Pehlivan';
  String _displayUsername = '@nurdanpehliivan';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Profil Düzenle',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                width: 322,
                height: 180,
                decoration: BoxDecoration(
                  color: const Color(0xFF773BFF),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/Avatar1.png'),
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _displayName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _displayUsername,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Alt kutular ve içerikleri
            buildInputField('İsim soyisim giriniz.', _nameController),
            const SizedBox(height: 25),
            buildInputField('Kullanıcı adı giriniz.', _usernameController),
            const SizedBox(height: 25),
            buildGenderSelection(), // Cinsiyet seçimi
            const SizedBox(height: 25),
            buildDateField('Doğum tarihi giriniz.'), // Doğum tarihi seçici
            const SizedBox(height: 25),
            buildPhoneNumberField(), // Telefon numarası alanı
            const SizedBox(height: 25),
            // Kaydet Butonu
            GestureDetector(
              onTap: () {
                setState(() {
                  _displayName = _nameController.text.isNotEmpty
                      ? _nameController.text
                      : _displayName;
                  _displayUsername = _usernameController.text.isNotEmpty
                      ? '@${_usernameController.text}'
                      : _displayUsername;
                });

                // Verilerin işlenmesi veya kaydedilmesi
                String name = _nameController.text;
                String username = _usernameController.text;
                String dob = _dobController.text;
                String phone = _phoneController.text;

                print('İsim Soyisim: $name');
                print('Kullanıcı Adı: $username');
                print('Doğum Tarihi: $dob');
                print('Telefon Numarası: $phone');
                print('Cinsiyet: $selectedGender');
              },
              child: Container(
                width: 300,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF773BFF),
                  borderRadius: BorderRadius.circular(36),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Kaydet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(String hintText, TextEditingController controller) {
    return Container(
      width: 343,
      height: 57,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 12),
        ),
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  Widget buildGenderSelection() {
    return Container(
      width: 343,
      height: 57,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedGender,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          DropdownButton<String>(
            value: selectedGender,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black, fontSize: 14),
            underline: Container(
              height: 0,
              color: Colors.transparent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                selectedGender = newValue!;
              });
            },
            items: <String>['Cinsiyet Seçiniz', 'Erkek', 'Kadın']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildDateField(String hintText) {
    return Container(
      width: 343,
      height: 57,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              controller: _dobController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(fontSize: 12),
              ),
              style: const TextStyle(fontSize: 12),
              readOnly: true,
              onTap: () => _selectDate(context),
            ),
          ),
          const Icon(Icons.calendar_today, color: Colors.grey),
        ],
      ),
    );
  }

  Widget buildPhoneNumberField() {
    return Container(
      width: 343,
      height: 57,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: IntlPhoneField(
        controller: _phoneController,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Telefon numarası giriniz.',
          hintStyle: TextStyle(fontSize: 12),
        ),
        initialCountryCode: 'TR',
        onChanged: (phone) {
          print(phone.completeNumber);
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }
  
}
