import 'package:dealsify_production/core/services/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_controllers/login.dart';

class LoginScreen extends StatelessWidget {
  final _loginController = Get.put(LoginController());
  LoginScreen({super.key});
  final loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: loginKey,
          child: Column(
            children: [
              const SizedBox(height: 400),
              _buildEmail(),
              const SizedBox(height: 30),
              _buildPassword(),
              const SizedBox(height: 24),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmail(){
    return Obx(() {
      return TextFormField(
        initialValue: _loginController.email.value,
        onChanged: (value) => _loginController.email(value),
        validator: (value) {
          if (value!.isEmpty) return 'Enter your email';
          if (value.isValidMail.isFalse) return 'Enter valid email';
          return null;
        },
        autofillHints: const [AutofillHints.email],
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'Email',
          labelStyle: const TextStyle(fontSize: 15),
          hintStyle: const TextStyle(fontSize: 15),
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),  // Smaller padding
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),),
        ),
      );
    },);
  }

  Widget _buildPassword(){
    return Obx(() {
      return TextFormField(
        onChanged: (value) => _loginController.password(value),
        obscureText: _loginController.hidePassword.isFalse ? true : false ,
        validator: (value) {
          if (value!.isEmpty) return "Enter password";
          return null;
          },
        autofillHints: const [AutofillHints.password],
        decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Password',
          labelStyle: const TextStyle(fontSize: 15),
          hintStyle: const TextStyle(fontSize: 15),
          suffixIcon: IconButton(
            onPressed: () {
              _loginController.hidePassword.value = !_loginController.hidePassword.value;
            },
            icon: _loginController.hidePassword.isTrue ?
            const Icon(Icons.visibility,) :
            const Icon(Icons.visibility_off,) ,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),  // Smaller padding
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),),
        ),
      );
    },);
  }

  Widget _buildLoginButton(){
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          if (loginKey.currentState!.validate()){
            "Login Success".show();
          } else {
            "Login Fail".show();
          }
        },
        child: const Text('Login'),
      ),
    );
  }

}