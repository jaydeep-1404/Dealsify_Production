
import 'package:dealsify_production/api/Models/POModel.dart';
import 'package:get/get.dart';

import '../../api/get/get_po_list.dart';

class PORecordCtrl extends GetxController {
  // Make poRecord observable by using Rx<ProductionOrderModel>
  var poRecord = ProductionOrderModel().obs;
  var poItemIndex = 0.obs;
  var productionMetaDataIndex = 0.obs;

  // Function to save a record
  void saveRecord(data) {
    poRecord.value = data ?? ProductionOrderModel();
  }

  // Save index for PO items
  void savePOItemIndex(index) => poItemIndex.value = index;

  // Save index for production metadata
  void saveProductionMetaDataIndex(index) => productionMetaDataIndex.value = index;

  // Clear the record by resetting the observable values
  void clearRecord() {
    poRecord.value = ProductionOrderModel();
    poItemIndex.value = 0;
    productionMetaDataIndex.value = 0;
  }

  // Check PO and refresh the data
  void checkPOAndRefresh() {
    try {
      // Access the first matching record and update poRecord observable
      poRecord.value = Get.put(PurchaseOrderController()).items.firstWhere(
            (record) => record.id == poRecord.value.id,
      );
      update();
    } catch (e, s) {
      print(s);
      // Handle error or set a default value if needed
    }
  }
}