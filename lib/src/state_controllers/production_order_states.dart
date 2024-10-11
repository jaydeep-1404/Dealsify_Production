
import 'package:dealsify_production/api/Models/POModel.dart';
import 'package:get/get.dart';

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
}