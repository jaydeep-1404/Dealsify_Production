import 'package:dealsify_production/core/services/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../api/auth/login.dart';

class LoginHandler extends GetxController {
  final _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(
        'data:text/html,<html><head><script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script></head><body><script type="text/javascript">function encryptString(input, key) {return CryptoJS.AES.encrypt(input, key).toString();}</script></body></html>'));

  var email = 'jaydeep@analogcloudtech.com'.obs;
  var password = 'Analog@2024'.obs;
  var passwordVisible = true.obs;

  void updateEmail(value) => email.value = value;

  void updatePassword(value) => password.value = value;

  void updateShowPassword() => passwordVisible.value = !passwordVisible.value;

  String? validatorEmail(String? value) {
    if (value!.isEmpty) return 'Enter your email';
    if (value.isValidMail == false) return 'Enter valid email';
    return null;
  }

  String? validatorPassword(value) {
    if (value == null || value.toString().isEmpty) return 'Enter your password';
    return null;
  }

  Future<void> check_validation_and_login(context,GlobalKey<FormState> loginKey) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (loginKey.currentState!.validate()) {
      var encryptedPass = await encryptPassword(password.value);
      Get.put(AuthController()).login(
        context,
        email: email.value.trim(),
        password: encryptedPass,
      );
    }
  }

  encryptPassword(value) async {
    var encryptionKey = "Analog@0518";
    var jsFunction = '''
      (function() {
        return encryptString("$value", "$encryptionKey");
      })();
    ''';

    try {
      final Object encryptedString = await _controller.runJavaScriptReturningResult(jsFunction);
      String withoutQuotes = encryptedString.toString().replaceAll('"', '');
      return withoutQuotes;
    } catch (e) {
      e.show();
      return '';
    }
  }

  void clear() {
    email.value = '';
    password.value = '';
    passwordVisible.value = false;
  }
}
