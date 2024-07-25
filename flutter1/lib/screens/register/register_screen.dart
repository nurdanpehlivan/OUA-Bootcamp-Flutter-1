import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter1/screens/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _fullName;
  late String _email;
  late String _password;

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
                  AppStrings.registerTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: AppDimensions.spacing),
                _buildRegisterForm(),
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

  Widget _buildRegisterForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildFullNameField(),
          const SizedBox(height: AppDimensions.spacing),
          _buildEmailField(),
          const SizedBox(height: AppDimensions.spacing),
          _buildPasswordField(),
          const SizedBox(height: AppDimensions.spacing),
          _buildRegisterButton(),
          const SizedBox(height: AppDimensions.spacing),
          _buildLoginPrompt(),
        ],
      ),
    );
  }

  Widget _buildFullNameField() {
    return TextFormField(
      decoration: AppDecorations.inputDecoration(
        labelText: AppStrings.fullNameLabel,
        prefixIcon: Icons.person,
      ).copyWith(
        prefixIcon: const Icon(Icons.person, color: AppColors.iconColor),
      ),
      style: const TextStyle(color: AppColors.textColor),
      validator: (value) =>
          value?.isEmpty ?? true ? AppStrings.fullNameRequired : null,
      onSaved: (value) => _fullName = value!,
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
      style: const TextStyle(color: AppColors.textColor),
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
      style: const TextStyle(color: AppColors.textColor),
      validator: (value) =>
          value?.isEmpty ?? true ? AppStrings.passwordRequired : null,
      onSaved: (value) => _password = value!,
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: _register,
      style: AppButtonStyles.primaryButton,
      child: const Text(AppStrings.registerButton),
    );
  }

  Widget _buildLoginPrompt() {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, '/login'),
      child: const Text(
        AppStrings.loginPrompt,
        style: TextStyle(color: AppColors.textColor),
      ),
    );
  }

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        User? user = userCredential.user;
        await user?.updateDisplayName(_fullName);

        DatabaseReference usersRef =
            FirebaseDatabase.instance.ref("users/${user?.uid}");
        await usersRef.set({
          "fullName": _fullName,
          "email": _email,
        });

        Navigator.pushReplacementNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        _showErrorDialog(e.message ?? AppStrings.unknownError);
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.errorTitle),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(AppStrings.okButton),
          )
        ],
      ),
    );
  }
}
