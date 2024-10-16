
import 'package:dealsify_production/api/Models/POModel.dart';
import 'package:get/get.dart';

import '../../api/get/get_po_list.dart';

class PORecordCtrl extends GetxController {
  var poRecord = ProductionOrderModel().obs;
  var activeStage = ProductionStages().obs;
  var poItemIndex = 0.obs;

  void saveRecord(data) {
    poRecord.value = data ?? ProductionOrderModel();
  }

  void saveStage(data) {
    activeStage.value = data ?? ProductionStages();
  }

  void savePOItemIndex(index) => poItemIndex.value = index;


  void clearRecord() {
    poRecord.value = ProductionOrderModel();
    poItemIndex.value = 0;
  }

  void checkPOAndRefresh() {
    try {
      poRecord.value = Get.put(PurchaseOrderController()).items.firstWhere(
            (record) => record.id == poRecord.value.id,
      );
      update();
    } catch (e, s) {
      print(s);
    }
  }
}