import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConstUrl {
  /// Base
  static String base_url  = dotenv.env['BASE_URL'] ?? '',
      auth_login_url          = '${base_url}auth/login';
}
