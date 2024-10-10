
import 'package:dealsify_production/api/Models/POModel.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PORecordCtrl extends GetxController {
  var poRecord = ProductionOrderModel();

  void saveRecord(data){
    poRecord = data ?? ProductionOrderModel();
  }

}