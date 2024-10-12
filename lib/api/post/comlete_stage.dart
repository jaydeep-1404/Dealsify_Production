import 'dart:convert';
import 'package:dealsify_production/core/services/extensions.dart';
import 'package:get/get.dart';
import '../../core/services/api_handler.dart';
import '../../core/services/server_urls.dart';

class CompleteStageController extends GetxController {
  var loading = false.obs;

  Future<void> post(id,payload) async {
    try {
      loading(true);
      var response = await ApiRequest.post(Uri.parse((ConstUrl.updateStages + id)), jsonEncode(payload));
      print("URL : ${ConstUrl.updateStages + id}");
      Map<String, dynamic> responseData = jsonDecode(response.body);
      responseData.printFormattedJson();
      // if (responseData[BKD.status].toString().isSuccess) {
      //   loading(false);
      // } else {
      //   loading(false);
      // }
    } on Exception catch (e, s) {
      e.show();
      s.show();
    } finally {
      loading(false);
    }
  }
}