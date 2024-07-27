import 'package:flutter/material.dart';
import '../register/login_screen.dart'; // Kendi dosya yapınıza göre düzenleyin

class SettingsBox extends StatefulWidget {
  const SettingsBox({super.key});

  @override
  _SettingsBoxState createState() => _SettingsBoxState();
}

class _SettingsBoxState extends State<SettingsBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Yüksekliği biraz artırdık
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildOption(
            icon: Icons.trending_up_rounded,
            title: 'İstatistikler',
            subtitle: 'İstatistikler görüntüle',
          ),
          const SizedBox(height: 16),
          _buildOption(
            icon: Icons.calendar_today,
            title: 'Günlük Yoklama',
            subtitle: 'Günlük yoklama yap',
            onTap: () {
              // Günlük Yoklama sayfasına geçiş kodu buraya eklenebilir.
            },
          ),
          const SizedBox(height: 16),
          _buildOption(
            icon: Icons.exit_to_app,
            title: 'Çıkış Yap',
            subtitle: 'Çıkış yapmak için tıkla',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
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
            child: Icon(icon),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
