import 'package:flutter/material.dart';

class AppColors {
  static const backgroundColor = Colors.black;
  static const textColor = Colors.white;
  static const iconColor = Colors.white;
  static const buttonColor = Color(0xFF773BFF);
  static const inputFillColor = Colors.white24;
}

class AppDimensions {
  static const double padding = 16.0;
  static const double spacing = 20.0;
  static const double smallSpacing = 10.0;
  static const double logoSize = 200.0;
  static const double borderRadius = 10.0;
}

class AppStrings {
  // Login strings
  static const loginTitle = 'Giriş Yap';
  static const emailLabel = 'Email';
  static const passwordLabel = 'Şifre';
  static const loginButton = 'Giriş Yap';
  static const forgotPassword = 'Şifrenizi mi unuttunuz?';
  static const registerPrompt = 'Hesabınız yok mu? Kayıt Olun';

  // Register strings
  static const registerTitle = 'Kayıt Ol';
  static const fullNameLabel = 'İsim Soyisim';
  static const registerButton = 'Kayıt Ol';
  static const loginPrompt = 'Zaten hesabınız var mı? Giriş Yapın';

  // Validation messages
  static const emailRequired = 'Lütfen email adresinizi girin';
  static const passwordRequired = 'Lütfen şifrenizi girin';
  static const fullNameRequired = 'Lütfen isminizi ve soyisminizi girin';

  // Error messages
  static const errorTitle = 'Hata';
  static const unknownError = 'Bilinmeyen bir hata oluştu';
  static const okButton = 'Tamam';
}

class AppAssets {
  static const logo = 'assets/CodeWiseLogo.jpg';
}

class AppDecorations {
  static InputDecoration inputDecoration({
    required String labelText,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: AppColors.textColor),
      prefixIcon: Icon(prefixIcon, color: AppColors.iconColor),
      fillColor: AppColors.inputFillColor,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        borderSide: BorderSide.none,
      ),
    );
  }
}

class AppButtonStyles {
  static final primaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.buttonColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
  );
}