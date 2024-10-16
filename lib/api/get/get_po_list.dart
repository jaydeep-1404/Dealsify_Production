import 'dart:convert';
import 'package:dealsify_production/core/services/extensions.dart';
import 'package:dealsify_production/core/services/local_storage.dart';
import 'package:get/get.dart';
import '../../core/services/api_handler.dart';
import '../../core/services/server_urls.dart';
import '../../core/services/strings.dart';
import '../../core/services/user_credentials.dart';
import '../Models/POModel.dart';

class PurchaseOrderController extends GetxController {
  var items = <ProductionOrderModel>[].obs;
  var loading = true.obs;
  var get_more = true.obs;

  var _startIndex = 1;
  final _limit = 100;
  final module = "Purchase Orders";

  @override
  void onClose() {
    clear();
    super.onClose();
  }

  Future<void> get({
    int? startIndex,
    String? searchType, String? searchValue,
    String? sortField, String? sortOrder,
  }) async {
    final LocalDataModel? prefData = await pref.get();

    Map<String, String> parameters = {
      BKD.companyId  : prefData!.company_id?.toString() ?? '',
      BKD.pageSize   : BKD.size,
      if (searchValue.toString().isNotEmpty && searchValue != null)BKD.filters    : filterJson(value: searchValue,log: true),
    };


    try {
      if (startIndex != null) loading(true);
      final response = await ApiRequest.get(Uri.parse((ConstUrl.po) + Uri(queryParameters: parameters).query));
      Map<String,dynamic> data = json.decode(response.body);
      data.printFormattedJson();
      AccessToken.expired(data);
      if (data[BKD.status] == true) {
        final items = List<ProductionOrderModel>.from(data[BKD.data].map((item) => ProductionOrderModel.fromJson(item)));
        if (startIndex != null) {
          this.items.addAll(items);
          loading(false);
        } else {
          this.items.assignAll(items);
        }
        get_more.value = items.length == _limit;
      } else {
        throw Exception();
      }
    } catch (e,s) {
      e.show();
      s.show();
    } finally {
      loading(false);
    }
  }

  void loadMore() {
    if (loading.value || !get_more.value) {
      return;
    }
    _startIndex++;
    get(startIndex: _startIndex);
  }

  void clear(){
    _startIndex = 1;
    loading = true.obs;
    items.clear();
  }
}

filterJson({value,log}){
  String filterJson = '[{'
      '"${BKD.fieldName}":"CustomerName",'
      '"${BKD.connector}":"is",'
      '"${BKD.value}":"${value?.toString().trim() ?? ''}"'
      '}]';
  if(log == true){filterJson.show();}
  String finalValue = value.toString().trim().isNotEmpty ? Uri.encodeComponent(filterJson) : '';
  return finalValue;
}