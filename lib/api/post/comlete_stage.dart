import 'dart:convert';
import 'package:dealsify_production/core/services/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../core/services/api_handler.dart';
import '../../core/services/server_urls.dart';

class CompleteStageController extends GetxController {
  var loading = false.obs;

  Future<void> post(id,payload) async {
    try {
      loading(true);
      var response = await ApiRequest.patch(Uri.parse((ConstUrl.updateStages + id)), payload);
      if (kDebugMode) {
        print("URL : ${ConstUrl.updateStages + id}");
      }
      Map<String, dynamic> responseData = jsonDecode(response.body);
      responseData.printFormattedJson();
      if (responseData["status"] == "success"){
        // final ctrl = Get.put(PageControllerGetX());
        // ctrl.completeStages!.add(ctrl.currentPage.value);
        // Open.stageUpdated();
        // ctrl.nextPage();
        // print("${ctrl.items!.length}");
        // if ((ctrl.currentPage.value + 1) == ctrl.items!.length){
        //   Get.back(canPop: true,closeOverlays: true);
        //   Get.put(PORecordCtrl()).checkPOAndRefresh();
        // }
      }
    } on Exception catch (e, s) {
      e.show();
      s.show();
    } finally {
      loading(false);
    }
  }
}