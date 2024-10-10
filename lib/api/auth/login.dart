import 'dart:convert';

import 'package:dealsify_production/core/services/extensions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../core/services/local_storage.dart';
import '../../core/services/server_urls.dart';
import '../../core/services/strings.dart';
import '../../src/common_functions/snackbars.dart';
import '../../src/state_controllers/login.dart';

class AuthController extends GetxController {
  final Map<String, String> _authHeaders = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };
  final RxBool loading = false.obs;

  bool get isLoading => loading.value;

  Future<void> login({required String email, required String password}) async {
    LocalDataModel? userInfo = await pref.get();

    try {
      loading.value = true;
      final response = await http.post(Uri.parse(ConstUrl.auth_login_url),
        headers: _authHeaders,
        body: jsonEncode({
          'email': email,
          'password': password,
          'autoLogin': 'true'
        }),
      );

      Map<String,dynamic> responseData = jsonDecode(response.body);

      if (responseData[BKD.status].toString().isSuccess) {
        TextInput.finishAutofillContext();

        Get.put(LoginHandler()).clear();

        userInfo!.access_token = "${responseData[BKD.data][BKD.access_token]}";
        userInfo.company_id = "${responseData[BKD.data][BKD.company_id]}";
        userInfo.user_id = "${responseData[BKD.data][BKD.id]}";
        pref.set(userInfo);

        // Open.credential_true_snackBar();
        // Get.offNamedUntil(ConstRoute.bottomNavigationBarPage, (_) => false);

      } else {
        // Open.credential_fail_snackBar();
      }
    } catch (e,StackTrace) {
      'LOGIN : $e'.show();
      'LOGIN : $StackTrace'.show();
      // Open.credential_fail_snackBar();
    } finally {
      loading.value = false;
    }
  }
}
