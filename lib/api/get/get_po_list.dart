import 'dart:convert';
import 'package:dealsify_production/core/services/extensions.dart';
import 'package:dealsify_production/core/services/local_storage.dart';
import 'package:get/get.dart';
import '../../core/services/api_handler.dart';
import '../../core/services/server_urls.dart';
import '../../core/services/strings.dart';
import '../../core/services/user_credentials.dart';
import '../Models/POModel.dart';
import '../Models/po_model_class.dart';

class PurchaseOrderController extends GetxController {
  var items = <ProductionOrder>[].obs;
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
    };

    try {
      if (startIndex != null) loading(true);
      final response = await ApiRequest.get(Uri.parse((ConstUrl.po) + Uri(queryParameters: parameters).query));
      Map<String,dynamic> data = json.decode(response.body);
      AccessToken.expired(data);
      if (data[BKD.status] == true) {
        final items = List<ProductionOrder>.from(data[BKD.data].map((item) => ProductionOrder.fromJson(item)));
        // print("CUSTOMER NAME : ${items.first.customerName}");
        data.printFormattedJson();
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
    // items.clear();
  }
}

// class PurchaseOrderListModel {
//   final String? id;
//   final String? orderDate;
//   final String? dispatchDate;
//   final String? expectedDate;
//   final String? productionOrderNo;
//   final String? isAutoGenSeq;
//   final String? customerId;
//
//   PurchaseOrderListModel({
//     this.id,
//     this.orderDate,
//     this.dispatchDate,
//     this.expectedDate,
//     this.productionOrderNo,
//     this.isAutoGenSeq,
//     this.customerId,
//   });
//
//   factory PurchaseOrderListModel.fromJson(Map<String, dynamic> json) {
//     return PurchaseOrderListModel(
//       id: json['_id']?.toString() ?? '',
//       orderDate: json['orderDate']?.toString() ?? '',
//       dispatchDate: json['dispatchDate']?.toString() ?? '',
//       expectedDate: json['expectedDate']?.toString() ?? '',
//       productionOrderNo: json['productionOrderNo']?.toString() ?? '',
//       isAutoGenSeq: json['isAutoGenSeq']?.toString() ?? '',
//       customerId: json['customerId']?['_id']?.toString() ?? '',
//       customerId: json['customerId']?['_id']?.toString() ?? '',
//       customerId: json['customerId']?['_id']?.toString() ?? '',
//       customerId: json['customerId']?['_id']?.toString() ?? '',
//     );
//   }
//
// }