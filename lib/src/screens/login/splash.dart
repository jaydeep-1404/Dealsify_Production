
import 'package:dealsify_production/src/common_functions/animations.dart';
import 'package:dealsify_production/src/screens/PO/purchase_orders.dart';
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

    if (userInfo.access_token != null && userInfo.access_token.toString().isNotEmpty) {
      navigateToPage(context, const DashboardScreen());
    } else {
      navigateToPage(context, const LoginScreen());
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
