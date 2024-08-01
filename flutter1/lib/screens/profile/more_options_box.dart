import 'package:flutter/material.dart';
import '../constants.dart'; // AppColors ve font ayarları için
import 'package:flutter1/screens/profile/faq_page.dart'; // FaqPage importu
import 'package:flutter1/screens/profile/help.dart'; // HelpPage importu

class MoreOptionsBox extends StatelessWidget {
  const MoreOptionsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.black, // Arka plan rengini siyah yap
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildOption(
            context: context,
            icon: Icons.help_outline,
            title: 'Yardım',
            subtitle: 'Yardıma mı ihtiyacınız var?',
            onTap: () {
              // Yardım sayfasına yönlendirme
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpPage()),
              );
            },
          ),
          const SizedBox(height: AppDimensions.smallSpacing),
          _buildOption(
            context: context,
            icon: Icons.question_answer,
            title: 'SSS',
            subtitle: 'Sıkça Sorulan Sorular',
            onTap: () {
              // SSS sayfasına yönlendirme
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FaqPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor:
                AppColors.backgroundColor, // İkonun arka plan rengi
            child: Icon(icon, color: AppColors.textColor), // İkon rengi
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
                    color: Colors.white, // Metin rengi beyaz
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Sora',
                    fontSize: 12,
                    color: Colors.grey, // Metin rengi gri
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
}
