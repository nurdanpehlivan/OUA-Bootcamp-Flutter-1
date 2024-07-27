import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter1/screens/constants.dart';
import 'package:flutter1/screens/quiz/flutterquiz.dart'; // Yeni sayfanın import edilmesi

class HomeScreenContent extends StatelessWidget {
  final User? user;

  const HomeScreenContent({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.padding),
            child: Text(
              'Hoşgeldin, ${user?.displayName ?? 'Kullanıcı'}!',
              style: const TextStyle(fontSize: 24, color: AppColors.textColor),
            ),
          ),
          const SizedBox(height: AppDimensions.spacing),
          _buildArticlesSection(context), // Bağlantı işlevselliği ekledik
          const SizedBox(height: AppDimensions.spacing),
          _buildProgrammingLanguagesSection(
              context), // Bağlantı işlevselliği ekledik
        ],
      ),
    );
  }

  Widget _buildArticlesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.padding),
          child: Text(
            'Makaleler',
            style: TextStyle(
                color: AppColors.textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: AppDimensions.smallSpacing),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildArticleCard(
                'Flutter ile Mobil Uygulama Geliştirmenin Avantajları',
                'https://via.placeholder.com/150',
                context,
              ),
              _buildArticleCard(
                'Backend Develop',
                'https://via.placeholder.com/150',
                context,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildArticleCard(
      String title, String imagePath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Makale başlığına tıklandığında yapılacak işlemler
        print('$title clicked');
      },
      child: Container(
        width: 300,
        margin: const EdgeInsets.only(left: AppDimensions.padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            ),
          ),
          padding: const EdgeInsets.all(AppDimensions.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: AppColors.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                'Read More...',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgrammingLanguagesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.padding),
          child: Text(
            'Yazılım Dilleri',
            style: TextStyle(
                color: AppColors.textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: AppDimensions.smallSpacing),
        _buildLanguageCard('Flutter', 'assets/flutter_logo.png', context),
        _buildLanguageCard('Python', 'assets/python_logo.png', context),
        _buildLanguageCard('Java', 'assets/java_logo.jpg', context),
      ],
    );
  }

  Widget _buildLanguageCard(
      String name, String logoPath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (name == 'Flutter') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FlutterPage()), // Yeni sayfaya geçiş
          );
        }
        // Diğer diller için başka sayfalara yönlendirme ekleyebilirsin
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.padding,
            vertical: AppDimensions.smallSpacing),
        padding: const EdgeInsets.all(AppDimensions.padding),
        decoration: BoxDecoration(
          color: AppColors.inputFillColor,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        ),
        child: Row(
          children: [
            Image.asset(logoPath, width: 40, height: 40),
            const SizedBox(width: AppDimensions.smallSpacing),
            Text(name,
                style:
                    const TextStyle(color: AppColors.textColor, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
