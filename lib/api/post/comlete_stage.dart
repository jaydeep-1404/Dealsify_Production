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
  var loadingStart = false.obs;
  var loadingEnd = false.obs;
  var loadingScrap = false.obs;
  var loadingComplete = false.obs;

  Future<void> post(id,payload,context, {isStart, isEnd, isComplete,isScrap}) async {
    try {
      if (isStart == true) loadingStart(true);
      if (isEnd == true) loadingEnd(true);
      if (isScrap == true) loadingScrap(true);
      if (isComplete == true) loadingComplete(true);

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
        if (isComplete == true){
          Open.stageUpdated(msg: "Stage completed successfully");
        } else {
          Open.stageUpdated();
        }
      } else {
        Open.openDateErrorSnackbar(responseData["message"]);
      }
    } on Exception catch (e, s) {
      Open.openDateErrorSnackbar("Fail");
      e.show();
      s.show();
    } finally {
      if (isStart == true) loadingStart(false);
      if (isEnd == true) loadingEnd(false);
      if (isScrap == true) loadingScrap(false);
      if (isComplete == true) loadingComplete(false);
    }
  }
}