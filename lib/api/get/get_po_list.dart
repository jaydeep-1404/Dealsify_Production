// import 'dart:convert';
//
// import 'package:dealsify_production/api/login.dart';
// import 'package:dealsify_production/core/services/extensions.dart';
// import 'package:get/get.dart';
//
// import '../../core/services/api_handler.dart';
// import '../../core/services/server_urls.dart';
// import '../../core/services/strings.dart';
// import '../../core/services/user_credentials.dart';
//
// class PurchaseOrderController extends GetxController {
//   var items = <PurchaseOrderListModel>[].obs;
//   var loading = true.obs;
//   var get_more = true.obs;
//
//   var _startIndex = 1;
//   final _limit = 100;
//   final module = "Purchase Orders";
//
//   @override
//   void onClose() {
//     clear();
//     super.onClose();
//   }
//
//   Future<void> get({
//     int? startIndex,
//     String? searchType, String? searchValue,
//     String? sortField, String? sortOrder,
//   }) async {
//
//     // Map<String, String> parameters = {
//     //   BKD.current    : emptyCheck2(value: startIndex,Empty: BKD.current_value,isNotEmpty: startIndex.toString()),
//     //   BKD.pageSize   : BKD.size,
//     //   BKD.sortField  : valueToKeyConvertSortField(sortField,module: module) ?? '',
//     //   BKD.sortOrder  : sortOrder ?? '',
//     //   BKD.filters    : filterJson(
//     //     log: true,
//     //     field: valueToKeyConvertFilter(searchType!.isEmpty ? defaultFilter(filterValue: searchType,from: module) : searchType,module: module) ?? '',
//     //     connector: searchType == Str.Date || searchType == Str.PO_Date || searchType == Str.Project_Delivery_Date ? BKD.is_between : BKD.with_contains,
//     //     value: searchValue ?? '',
//     //   ),
//     // };
//
//     // parameters.printFormattedJson();
//
//     try {
//       if (startIndex != null) loading(true);
//       final response = await ApiRequest.get(Uri.parse((ConstUrl.po + UrlType.get) + Uri(queryParameters: parameters).query));
//       final data = json.decode(response.body);
//       // AccessToken.expired(data);
//       if (data[BKD.status] == true) {
//         final items = List<PurchaseOrderListModel>.from(data[BKD.data].map((item) => PurchaseOrderListModel.fromJson(item)));
//         if (startIndex != null) {
//           this.items.addAll(items);
//           loading(false);
//         } else {
//           this.items.assignAll(items);
//         }
//         get_more.value = items.length == _limit;
//       } else {
//         throw Exception();
//       }
//     } catch (e,s) {
//       e.show();
//       s.show();
//     } finally {
//       loading(false);
//     }
//   }
//
//   void loadMore() {
//     if (loading.value || !get_more.value) {
//       return;
//     }
//     _startIndex++;
//     get(startIndex: _startIndex);
//   }
//
//   void clear(){
//     _startIndex = 1;
//     loading = true.obs;
//     items.clear();
//   }
//
//   // void callApi({onlySorting,onlyFilter,both,loading}){
//   //   final fs = Get.put(FilterSortingHandler());
//   //   if(loading != false)clear();
//   //
//   //   if(onlySorting == true){
//   //     get(
//   //       startIndex: _startIndex,
//   //       sortField: fs.sorting.value,
//   //       sortOrder: fs.sortOrder.value,
//   //       searchValue: '',
//   //       searchType: '',
//   //     );
//   //   }
//   //
//   //   if(onlyFilter == true){
//   //     get(
//   //       startIndex: _startIndex,
//   //       searchValue: (fs.filter.value == Str.Date || fs.filter.value == Str.PO_Date || fs.filter.value == Str.Project_Delivery_Date ? '${fs.formattedDate},${fs.formattedDate}' : fs.search.text),
//   //       searchType: fs.filter.value,
//   //       sortField: '',
//   //       sortOrder: '',
//   //     );
//   //   }
//   //
//   //   if(both == true){
//   //     get(
//   //       startIndex: _startIndex,
//   //       searchValue: (fs.filter.value == Str.Date || fs.filter.value == Str.PO_Date || fs.filter.value == Str.Project_Delivery_Date ? '${fs.formattedDate},${fs.formattedDate}' : fs.search.text),
//   //       searchType: fs.filter.value,
//   //       sortField: fs.sorting.value,
//   //       sortOrder: fs.sortOrder.value,
//   //     );
//   //   }
//   // }
// }
//
// class PurchaseOrderListModel {
//   final String? id,
//       customer_id,
//       name,
//       date,
//       financial_year_id,
//       place_of_supply,
//       place_of_supply_name,
//       supply_Country_Id,
//       destination_Country_Id,
//       destination_of_supply,
//       destination_of_supply_name,
//       destination_Country_Name,
//       supply_Country_Name,
//       email,
//       total,
//       rounding,
//       grand_total,
//       payment_terms_id,
//       payment_terms_name,
//
//       notes,
//       company_id,
//       po_no,
//       projected_delivery_date,
//       s_city,
//       s_pincode,
//       s_address_1,
//       s_address_2,
//       s_address_3,
//       s_country_id,
//       s_country_name,
//       s_state_id,
//       s_state_name;
//   final bool? isAutoGenSeq;
//   List<Items>? purchase_items;
//   List<ItemTaxation>? Item_Taxation;
//
//   PurchaseOrderListModel({
//     this.id,
//     this.customer_id,
//     this.name,
//     this.date,
//     this.financial_year_id,
//     this.place_of_supply,
//     this.place_of_supply_name,
//     this.supply_Country_Id,
//     this.destination_Country_Id,
//     this.destination_of_supply,
//     this.destination_of_supply_name,
//     this.destination_Country_Name,
//     this.supply_Country_Name,
//     this.email,
//     this.total,
//     this.rounding,
//     this.grand_total,
//     this.payment_terms_id,
//     this.payment_terms_name,
//     this.notes,
//     this.company_id,
//     this.po_no,
//     this.isAutoGenSeq,
//     this.projected_delivery_date,
//     this.s_city,
//     this.s_pincode,
//     this.s_address_1,
//     this.s_address_2,
//     this.s_address_3,
//     this.s_country_id,
//     this.s_country_name,
//     this.s_state_id,
//     this.s_state_name,
//     this.purchase_items,
//     this.Item_Taxation,
//   });
//
//   factory PurchaseOrderListModel.fromJson(Map<String, dynamic> json) {
//     List<dynamic> items = json['purchase_items']  ?? [];
//     List<Items> item_list = items.map((item) => Items.fromJson(item)).toList();
//
//     List<dynamic>? item_taxation = json['itemTaxation']  ?? [];
//     List<ItemTaxation> item_taxation_list = item_taxation != null ? item_taxation.map((item) => ItemTaxation.fromJson(item)).toList() : [];
//
//     return PurchaseOrderListModel(
//       purchase_items: item_list,
//       Item_Taxation: item_taxation_list,
//       id: json['_id']?.toString() ?? '',
//       date: json['po_date']?.toString() ?? '',
//       customer_id: json['customer_id']?['_id']?.toString() ?? '',
//       name: json['customer_id']?['customer_name']?.toString() ?? '',
//       financial_year_id: json['financial_year_id']?.toString() ?? '',
//       place_of_supply: json['place_of_supply']?.toString() ?? '',
//       supply_Country_Id: json['supplyCountryId']?.toString() ?? '',
//       place_of_supply_name: json['place_of_supply_name']?.toString() ?? '',
//       destination_of_supply: json['destinationOfSupply']?.toString() ?? '',
//       destination_of_supply_name: json['destinationOfSupplyName']?.toString() ?? '',
//       destination_Country_Id: json['destinationCountryId']?.toString() ?? '',
//       destination_Country_Name: json['destinationCountryName']?.toString() ?? '',
//       supply_Country_Name: json['supplyCountryName']?.toString() ?? '',
//       email: json['email']?.toString() ?? '',
//       total: json['total']?.toString() ?? '',
//       grand_total: json['grand_total']?.toString() ?? '',
//       rounding: json['rounding']?.toString() ?? '',
//       payment_terms_id: json['payment_terms_id']?['_id']?.toString() ?? '',
//       payment_terms_name: json['payment_terms_id']?['payment_terms_name']?.toString() ?? '',
//       notes: json['notes']?.toString() ?? '',
//       company_id: json['company_id']?.toString() ?? '',
//       po_no: json['po_no']?.toString() ?? '',
//       isAutoGenSeq: json['isAutoGenSeq'] ?? true,
//       projected_delivery_date: json['projected_delivery_date']?.toString() ?? '',
//
//       s_country_name: json["shippingAddress"] ? ["country"] ? ["name"] ?? '',
//       s_country_id:   json["shippingAddress"] ? ["country"] ? ["id"] ?? '',
//       s_state_name:   json["shippingAddress"] ? ["state"] ? ["name"] ?? '',
//       s_state_id:     json["shippingAddress"] ? ["state"] ? ["id"] ?? '',
//       s_city:         json["shippingAddress"] ? ["city"] ?? '',
//       s_pincode:      json["shippingAddress"] ? ["pincode"] ?? '',
//       s_address_1:    json["shippingAddress"] ? ["addressLine1"] ?? '',
//       s_address_2:    json["shippingAddress"] ? ["addressLine2"] ?? '',
//       s_address_3:    json["shippingAddress"] ? ["addressLine3"] ?? '',
//
//     );
//   }
//
// }