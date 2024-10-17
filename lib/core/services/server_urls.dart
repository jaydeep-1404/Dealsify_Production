
class ConstUrl {
  /// Base
  static String base_url  = "https://dealsify-backend-mongodb.vercel.app/v1/",
      auth_login_url          = '${base_url}auth/login';

  static String po  = "${base_url}production-order/item-wise-orders?";
  // static String po  = "${base_url}production-order?&";
  static String updateStages = "${base_url}production-order/update-po-stages/";

}

class UrlType{
  static const String
  get        = 'get-all?',
      create     = 'create',
      delete     = 'delete/',
      update     = 'update/',
      getRecord  = 'edit/',
      bulkDelete = 'bulk-delete/';
}