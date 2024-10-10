import 'package:dealsify_production/api/login.dart';
import 'package:dealsify_production/core/services/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_controllers/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
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
  void dispose(){
    focusNodeEmail.dispose();
    focusNodePass.dispose();
    super.dispose();
  }

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
        initialValue: controller.email.value,
        focusNode: focusNodeEmail,
        onChanged: controller.updateEmail,
        validator: controller.validatorEmail,
        onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(focusNodePass),
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
        initialValue: controller.password.value,
        onChanged: controller.updatePassword,
        focusNode: focusNodePass,
        obscureText: controller.passwordVisible.isFalse ? true : false ,
        validator: controller.validatorPassword,
        autofillHints: const [AutofillHints.password],
        decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Password',
          labelStyle: const TextStyle(fontSize: 15),
          hintStyle: const TextStyle(fontSize: 15),
          suffixIcon: IconButton(
            onPressed: controller.updateShowPassword,
            icon: controller.passwordVisible.isTrue ?
            const Icon(Icons.visibility,) :
            const Icon(Icons.visibility_off,),
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
        onPressed: () => controller.check_validation_and_login(loginKey),
        child:  Get.put(AuthController()).isLoading.isTrue ?
        const SizedBox(height: 20,width: 20,child: CircularProgressIndicator(strokeWidth: 2,),) :
        const Text('Login'),
      ),
    );
  }
}
