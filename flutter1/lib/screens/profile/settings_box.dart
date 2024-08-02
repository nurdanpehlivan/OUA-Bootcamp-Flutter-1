import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../register/login_screen.dart'; // Kendi dosya yapınıza göre düzenleyin
import '../constants.dart'; // AppColors ve font ayarları için

class SettingsBox extends StatefulWidget {
  const SettingsBox({super.key});

  @override
  _SettingsBoxState createState() => _SettingsBoxState();
}

class _SettingsBoxState extends State<SettingsBox> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140, // Yüksekliği sabitledik
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppDimensions.padding),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppDimensions.smallSpacing),
                _buildOption(
                  icon: Icons.feedback,
                  title: 'Geri Bildirim',
                  subtitle: 'Geri bildirimde bulunun',
                  onTap: () => _showFeedbackDialog(),
                ),
                const SizedBox(height: AppDimensions.smallSpacing),
                _buildOption(
                  icon: Icons.exit_to_app,
                  title: 'Çıkış Yap',
                  subtitle: 'Çıkış yapmak için tıkla',
                  onTap: () => _showSignOutConfirmationBottomSheet(),
                ),
              ],
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor:
                AppColors.backgroundColor, // İkonun arka plan rengi
            child: Icon(icon, color: AppColors.textColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Sora',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontFamily: 'Sora',
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textColor),
        ],
      ),
    );
  }

  void _showFeedbackDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black, // Arka plan rengini siyah yaptık
          title: const Text(
            'Geri Bildirim',
            style: TextStyle(
              fontFamily: 'Sora',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height *
                    0.5, // Maksimum yükseklik
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Geri bildiriminizi buraya yazabilirsiniz:',
                    style: TextStyle(
                      fontFamily: 'Sora',
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    maxLines: 5,
                    style: TextStyle(
                      fontFamily: 'Sora',
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: 'Geri bildiriminizi buraya yazın...',
                      hintStyle: TextStyle(
                        fontFamily: 'Sora',
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'İptal',
                style: TextStyle(
                  fontFamily: 'Sora',
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Geri bildirim gönderme kodu buraya eklenebilir
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Geri bildiriminiz gönderildi. Teşekkürler!'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Buton rengi
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Gönder',
                style: TextStyle(
                  fontFamily: 'Sora',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSignOutConfirmationBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.black, // Arka plan rengini siyah yaptık
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppDimensions.borderRadius)),
          ),
          padding: const EdgeInsets.all(AppDimensions.padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                size: 48,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              const Text(
                'Çıkış Yap',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Başlık rengi
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Çıkış yapmak istiyor musunuz?',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Sora',
                  color: Colors.grey[400], // Alt yazı rengi
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[600], // Buton rengi
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.borderRadius),
                      ),
                    ),
                    child: const Text(
                      'Hayır',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Sora',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await _signOut();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Buton rengi
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.borderRadius),
                      ),
                    ),
                    child: const Text(
                      'Evet',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Sora',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _signOut() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Çıkış yapma sırasında bir hata oluştu.'),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
