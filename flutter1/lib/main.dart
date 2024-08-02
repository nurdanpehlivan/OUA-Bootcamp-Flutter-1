import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter1/screens/home/home_screen.dart';
import 'package:flutter1/screens/register/login_screen.dart';
import 'package:flutter1/screens/register/register_screen.dart';
import 'package:flutter1/screens/profile/profile_screen.dart';
import 'package:flutter1/screens/categories/categories_page.dart';
import 'package:flutter1/screens/profile/faq_page.dart'; // FaqPage importu ekleyin

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthWrapper(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/categories': (context) => const CategoriesPage(),
        '/faqPage': (context) => const FaqPage(), // FaqPage rotasını ekleyin
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Eğer hala kullanıcı durumunu kontrol ediyorsa bir yüklenme göstergesi göster
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          // Eğer kullanıcı oturum açmışsa ana sayfaya yönlendir
          return const HomeScreen();
        } else {
          // Eğer kullanıcı oturum açmamışsa kayıt sayfasına yönlendir
          return const RegisterScreen();
        }
      },
    );
  }
}
