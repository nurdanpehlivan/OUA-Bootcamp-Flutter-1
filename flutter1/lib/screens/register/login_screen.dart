import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
                const SizedBox(height: AppDimensions.spacing),
                Text(
                  AppStrings.loginTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: AppDimensions.spacing),
                _buildLoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return ClipOval(
      child: Image.asset(
        AppAssets.logo,
        width: AppDimensions.logoSize,
        height: AppDimensions.logoSize,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildEmailField(),
          const SizedBox(height: AppDimensions.spacing),
          _buildPasswordField(),
          const SizedBox(height: AppDimensions.smallSpacing),
          _buildForgotPasswordButton(),
          const SizedBox(height: AppDimensions.spacing),
          _buildLoginButton(),
          const SizedBox(height: AppDimensions.spacing),
          _buildRegisterButton(),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: AppDecorations.inputDecoration(
        labelText: AppStrings.emailLabel,
        prefixIcon: Icons.email,
      ).copyWith(
        prefixIcon: const Icon(Icons.email, color: AppColors.iconColor),
      ),
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        color: AppColors.textColor,
        fontFamily: "Sora",
      ),
      validator: (value) =>
          value?.isEmpty ?? true ? AppStrings.emailRequired : null,
      onSaved: (value) => _email = value!,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: AppDecorations.inputDecoration(
        labelText: AppStrings.passwordLabel,
        prefixIcon: Icons.lock,
      ).copyWith(
        prefixIcon: const Icon(Icons.lock, color: AppColors.iconColor),
      ),
      obscureText: true,
      style: const TextStyle(
        color: AppColors.textColor,
        fontFamily: "Sora",
      ),
      validator: (value) =>
          value?.isEmpty ?? true ? AppStrings.passwordRequired : null,
      onSaved: (value) => _password = value!,
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // TODO: Implement forgot password functionality
        },
        child: const Text(AppStrings.forgotPassword,
            style: TextStyle(
              color: AppColors.textColor,
              fontFamily: "Sora",
            )),
      ),
    );
  }

  Widget _buildLoginButton() {
    return _isLoading
        ? const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.buttonColor),
          )
        : ElevatedButton(
            onPressed: _login,
            style: AppButtonStyles.primaryButton,
            child: const Text(
              AppStrings.loginButton,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Sora",
              ),
            ),
          );
  }

  Widget _buildRegisterButton() {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, '/register'),
      child: const Text(AppStrings.registerPrompt,
          style: TextStyle(
            color: AppColors.textColor,
            fontFamily: "Sora",
          )),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        setState(() {
          _isLoading = false;
        });
        AppUtils.showToast(context, "Giriş başarılı!");
        Navigator.pushReplacementNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });
        String errorMessage;
        switch (e.code) {
          case 'invalid-email':
            errorMessage = 'Geçersiz email adresi';
            break;
          case 'user-disabled':
            errorMessage = 'Kullanıcı devre dışı bırakılmış';
            break;
          case 'user-not-found':
            errorMessage = 'Kullanıcı bulunamadı';
            break;
          case 'wrong-password':
            errorMessage = 'Yanlış şifre';
            break;
          default:
            errorMessage = AppStrings.unknownError;
        }
        AppUtils.showErrorDialog(context, errorMessage);
      }
    }
  }
}
