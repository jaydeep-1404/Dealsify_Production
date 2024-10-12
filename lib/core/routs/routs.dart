import 'package:dealsify_production/src/screens/dashboard/dashboard.dart';
import 'package:dealsify_production/src/screens/login/login.dart';
import 'package:dealsify_production/src/screens/PO/po_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../src/screens/PO/add_po.dart';

class ConstRoute {
  static const String splashScreen = '/splashScreen',
      loginPage = '/loginPage',
      dashboard = '/dashboard',
      poItems = '/poItems',
      productionMetaData = '/productionMetaData',
      poCreate = '/poCreate';
}

class RoutePage {
  static const initial = ConstRoute.splashScreen;
  static const login = ConstRoute.dashboard;

  static const duration = Duration(milliseconds: 100),
      left = Transition.rightToLeft,
      right = Transition.leftToRight;

  static List<GetPage> routes = [
    GetPage(name: ConstRoute.loginPage, page: () => const LoginScreen()),
    GetPage(name: ConstRoute.dashboard, page: () => const DashboardScreen()),
    GetPage(name: ConstRoute.poItems, page: () => const POItemsPage()),
    // GetPage(name: ConstRoute.productionMetaData, page: () => const ProductionMetaDataList()),
    GetPage(name: ConstRoute.poCreate, page: () => const CreatePurchaseOrder()),
  ];
}