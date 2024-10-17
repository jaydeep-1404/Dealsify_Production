
import 'package:dealsify_production/api/Models/POModel.dart';
import 'package:dealsify_production/api/Models/bomItems.dart';
import 'package:dealsify_production/api/Models/stages.dart';
import 'package:get/get.dart';
import '../../api/get/get_po_list.dart';

class PORecordCtrl extends GetxController {
  var poRecord = ProductionOrderModel().obs;
  var activeStage = ProductionStages().obs;
  var bomItems = <BomItems>[].obs;

  void saveRecord(data) {
    poRecord.value = data ?? ProductionOrderModel();
  }

  void saveStage(data) {
    activeStage.value = data ?? ProductionStages();
  }

  void saveBomItems(data) {
    bomItems.value = [];
    bomItems.assignAll(data);
  }


  void clearAll(){
    poRecord = ProductionOrderModel().obs;
    activeStage = ProductionStages().obs;
    bomItems = <BomItems>[].obs;
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