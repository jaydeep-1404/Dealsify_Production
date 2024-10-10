import 'package:dealsify_production/src/screens/login/login.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class ConstRoute {
  static const String splashScreen = '/splashScreen',
      loginPage = '/loginPage';
}

class RoutePage {
  static const initial = ConstRoute.splashScreen;
  static const login = ConstRoute.loginPage;

  static const duration = Duration(milliseconds: 100),
      left = Transition.rightToLeft,
      right = Transition.leftToRight;

  static List<GetPage> routes = [
    GetPage(name: ConstRoute.loginPage, page: () => const LoginScreen())
  ];
}