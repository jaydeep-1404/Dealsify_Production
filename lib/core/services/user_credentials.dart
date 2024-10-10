// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types
import 'local_storage.dart';

/// Token handler [AccessToken]
class AccessToken {
  static Future<Map<String, String>?> token() async {
    LocalDataModel? userInfo = await pref.get();
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userInfo!.access_token}'
    };
    return header;
  }

  // static void expired(response) async {
  //   if(response[BKD.errors] == BKD.Unauthorized){
  //     Api.clearApiCaughtOnLogout();
  //     Get.off(() => const LoginPage());
  //     Open.warningSnackBar("Session expired try to login");
  //   }
  // }
}
