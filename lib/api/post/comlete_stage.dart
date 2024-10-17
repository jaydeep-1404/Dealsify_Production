import 'dart:convert';
import 'package:dealsify_production/core/services/extensions.dart';
import 'package:dealsify_production/src/common_functions/animations.dart';
import 'package:dealsify_production/src/screens/PO/purchase_orders.dart';
import 'package:dealsify_production/src/state_controllers/scrap_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../core/services/api_handler.dart';
import '../../core/services/server_urls.dart';
import '../../src/common_functions/snackbars.dart';
import '../../src/state_controllers/production_order_states.dart';
import '../../src/state_controllers/stage_controller.dart';

class CompleteStageController extends GetxController {
  var loading = false.obs;

  Future<void> post(id,payload,context) async {
    try {
      loading(true);
      var response = await ApiRequest.patch(Uri.parse((ConstUrl.updateStages + id)), payload);
      if (kDebugMode) {
        print("URL : ${ConstUrl.updateStages + id}");
      }
      Map<String, dynamic> responseData = jsonDecode(response.body);
      responseData.printFormattedJson();
      if (responseData["status"] == "success"){
        Get.put(PORecordCtrl()).clearAll();
        Get.put(StageController()).clearAll();
        Get.put(ScrapController()).clearAll();
        navigateToPage(context, const DashboardScreen());
        Open.openDateErrorSnackbar(responseData["message"]);
      } else {
        Open.openDateErrorSnackbar(responseData["message"]);
      }
    } on Exception catch (e, s) {
      Open.openDateErrorSnackbar("Fail");
      e.show();
      s.show();
    } finally {
      loading(false);
    }
  }
}