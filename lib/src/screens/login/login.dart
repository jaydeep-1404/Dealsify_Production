import 'package:dealsify_production/api/auth/login.dart';
import 'package:dealsify_production/core/services/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_functions/animations.dart';
import '../../state_controllers/login.dart';

/*
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
        onPressed: () => controller.check_validation_and_login(context,loginKey),
        child: Get.put(AuthController()).isLoading.isTrue ?
        const SizedBox(height: 20,width: 20,child: CircularProgressIndicator(strokeWidth: 2,),) :
        const Text('Login'),
      ),
    );
  }
}
*/



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
  void dispose(){
    focusNodeEmail.dispose();
    focusNodePass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: BackgroundPainter(),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: loginKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildEmail(),
                    const SizedBox(height: 15),
                    _buildPassword(),
                    const SizedBox(height: 30),
                    _buildLoginButton(),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.blueAccent, width: 2), // Added border
          ),
          child: Obx(() {
            return TextFormField(
              initialValue: controller.email.value,
              focusNode: focusNodeEmail,
              onChanged: controller.updateEmail,
              validator: controller.validatorEmail,
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(focusNodePass),
              autofillHints: const [AutofillHints.email],
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Email',
                labelStyle: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            );
          },),
        ),
      ],
    );
  }

  Widget _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.blueAccent, width: 2), // Added border
          ),
          child: Obx(() {
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
                hintStyle: const TextStyle(fontSize: 15),
                suffixIcon: IconButton(
                  onPressed: controller.updateShowPassword,
                  icon: controller.passwordVisible.isTrue ?
                  const Icon(Icons.visibility,) :
                  const Icon(Icons.visibility_off,),
                ),
                labelStyle: const TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            );
          },),
        ),
      ],
    );
  }

  Widget _buildLoginButton(){
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () => controller.check_validation_and_login(context,loginKey),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.white,
          elevation: 5,
        ),
        child: Get.put(AuthController()).isLoading.isTrue ?
        const SizedBox(height: 20,width: 20,child: CircularProgressIndicator(strokeWidth: 2,),) :
        const Text('Login'),

      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.blueAccent, Colors.lightBlueAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    final path = Path()
      ..lineTo(0, size.height * 0.6)
      ..quadraticBezierTo(
        size.width / 2,
        size.height * 0.75,
        size.width,
        size.height * 0.6,
      )
      ..lineTo(size.width, 0)
      ..close();

    paint.color = Colors.white.withOpacity(0.1);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}