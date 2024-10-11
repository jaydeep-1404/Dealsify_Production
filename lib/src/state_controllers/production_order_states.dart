
import 'package:dealsify_production/api/Models/POModel.dart';
import 'package:dealsify_production/src/screens/PO/metadata_list.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PORecordCtrl extends GetxController {
  var poRecord = ProductionOrderModel();
  var productionMetadata = ProductionMetadata();

  void saveRecord(data){
    poRecord = data ?? ProductionOrderModel();
  }

  void saveProductionMetaData(data){
    productionMetadata = data ?? ProductionMetadata();
  }

}