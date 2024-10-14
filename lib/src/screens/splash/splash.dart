
import 'package:dealsify_production/src/screens/dashboard/dashboard.dart';
import 'package:dealsify_production/src/screens/login/login.dart';
import 'package:flutter/material.dart';
import '../../../core/services/local_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var userInfo = LocalDataModel();

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  Future<void> checkToken() async {
    await Future.delayed(const Duration(seconds: 2));
    userInfo = (await pref.get())!;

    if (userInfo.access_token != null && userInfo.access_token.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 1),
          pageBuilder: (context, animation, secondaryAnimation) => const DashboardScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 1),
          pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    }
  }

  Future<void> getDataFromLocal() async => userInfo = (await pref.get())!;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
