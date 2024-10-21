import 'package:dealsify_production/api/auth/login.dart';
import 'package:dealsify_production/core/services/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_controllers/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginHandler());
  late FocusNode focusNodeEmail = FocusNode(), focusNodePass = FocusNode();
  final loginKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.closeAllSnackbars();
    super.initState();
  }

  @override
  void dispose() {
    focusNodeEmail.dispose();
    focusNodePass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.lightBlue[50],
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: loginKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                        "assets/dealsify-02.png",
                      width: 200,
                    ),
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildEmail(),
                    const SizedBox(height: 15),
                    _buildPassword(),
                    const SizedBox(height: 30),
                    _buildLoginButton(),
                    const SizedBox(height: 20),
                    _buildForgotPassword(),
                    const SizedBox(height: 20),
                    _buildSignUpPrompt(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmail() {
    return Container(
      decoration: _inputContainerDecoration(),
      child: Obx(() {
        return TextFormField(
          initialValue: controller.email.value,
          focusNode: focusNodeEmail,
          onChanged: controller.updateEmail,
          validator: controller.validatorEmail,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(focusNodePass),
          autofillHints: const [AutofillHints.email],
          keyboardType: TextInputType.emailAddress,
          decoration: _inputDecoration(label: 'Email', hint: 'Enter your email'),
        );
      }),
    );
  }

  Widget _buildPassword() {
    return Container(
      decoration: _inputContainerDecoration(),
      child: Obx(() {
        return TextFormField(
          initialValue: controller.password.value,
          onChanged: controller.updatePassword,
          focusNode: focusNodePass,
          obscureText: !controller.passwordVisible.value,
          validator: controller.validatorPassword,
          autofillHints: const [AutofillHints.password],
          decoration: _inputDecoration(
            label: 'Password',
            hint: 'Enter your password',
            suffixIcon: IconButton(
              onPressed: controller.updateShowPassword,
              icon: controller.passwordVisible.value
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blueAccent, Colors.lightBlueAccent],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => controller.check_validation_and_login(context, loginKey),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        child: Get.put(AuthController()).isLoading.isTrue
            ? const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )
            : const Text(
          'Login',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return TextButton(
      onPressed: () {
      },
      child: const Text(
        'Forgot Password?',
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
    );
  }

  Widget _buildSignUpPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account? ',
          style: TextStyle(color: Colors.black),
        ),
        TextButton(
          onPressed: () {
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({required String label, required String hint, Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      suffixIcon: suffixIcon,
      labelStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    );
  }

  BoxDecoration _inputContainerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 8,
          spreadRadius: 1,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}