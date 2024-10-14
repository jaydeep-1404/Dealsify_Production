
import 'package:dealsify_production/api/Models/POModel.dart';
import 'package:get/get.dart';

import '../../api/get/get_po_list.dart';

class PORecordCtrl extends GetxController {
  var poRecord = ProductionOrderModel();
  var poItemIndex = 0.obs;
  var productionMetaDataIndex = 0.obs;

  void saveRecord(data){
    poRecord = data ?? ProductionOrderModel();
  }

  void savePOItemIndex(index) => poItemIndex.value = index;
  void saveProductionMetaDataIndex(index) => productionMetaDataIndex.value = index;

  void clearRecord(){
    poRecord = ProductionOrderModel();
    poItemIndex = 0.obs;
    productionMetaDataIndex = 0.obs;
  }

  checkPOAndRefresh(){
    try {
      return Get.put(PurchaseOrderController()).items.firstWhere((record) => record.id == poRecord.id);
    } catch (e, s) {
      print(s);
      return ProductionOrderModel();
    }
  }
}