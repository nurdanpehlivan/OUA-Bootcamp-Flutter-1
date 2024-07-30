import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore için ekledik
import '../register/login_screen.dart'; // Kendi dosya yapınıza göre düzenleyin
import '../constants.dart'; // AppColors ve font ayarları için

class SettingsBox extends StatefulWidget {
  const SettingsBox({super.key});

  @override
  _SettingsBoxState createState() => _SettingsBoxState();
}

class _SettingsBoxState extends State<SettingsBox> {
  bool _isLoading = false;
  String _bio = '';

  @override
  void initState() {
    super.initState();
    _fetchBio();
  }

  Future<void> _fetchBio() async {
    setState(() {
      _isLoading = true;
    });

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final docSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        final data = docSnapshot.data();
        setState(() {
          _bio =
              data?['bio'] ?? 'Bio eklenmemiş'; // Kullanıcının bio bilgisini al
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bio bilgisi yüklenemedi: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Yüksekliği biraz artırdık
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Bio kısmı
              const Text(
                'Bio',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: AppDimensions.smallSpacing),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                Text(
                  _bio,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: 'Sora',
                  ),
                ),
              const SizedBox(height: AppDimensions.smallSpacing),
              _buildOption(
                icon: Icons.trending_up_rounded,
                title: 'İstatistikler',
                subtitle: 'İstatistikler görüntüle',
              ),
              const SizedBox(height: AppDimensions.smallSpacing),
              _buildOption(
                icon: Icons.calendar_today,
                title: 'Günlük Yoklama',
                subtitle: 'Günlük yoklama yap',
                onTap: () {
                  // Günlük Yoklama sayfasına geçiş kodu buraya eklenebilir.
                },
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

  void _showSignOutConfirmationBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
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
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Çıkış yapmak istiyor musunuz?',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Sora',
                  color: Colors.grey[600],
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
                      backgroundColor: Colors.grey,
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
                      backgroundColor: Colors.red,
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
