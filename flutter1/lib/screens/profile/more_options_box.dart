import 'package:flutter/material.dart';
import '../constants.dart'; // AppColors ve font ayarları için

class MoreOptionsBox extends StatelessWidget {
  const MoreOptionsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildOption(
            icon: Icons.help_outline,
            title: 'Yardım',
            subtitle: 'Yardıma mı ihtiyacınız var?',
          ),
          const SizedBox(height: AppDimensions.smallSpacing),
          _buildOption(
            icon: Icons.question_answer,
            title: 'SSS',
            subtitle: 'Sıkça Sorulan Sorular',
          ),
        ],
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.backgroundColor, // İkonun arka plan rengi
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
                  color: Colors.black,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, color: AppColors.textColor),
      ],
    );
  }
}
