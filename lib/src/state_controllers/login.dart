import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var hidePassword = true.obs;

  void showPass(){
    hidePassword.value = !hidePassword.value;
  }

}