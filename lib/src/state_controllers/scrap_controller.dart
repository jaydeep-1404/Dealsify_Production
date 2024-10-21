
import 'package:dealsify_production/api/Models/bomItems.dart';
import 'package:dealsify_production/src/state_controllers/production_order_states.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_functions/snackbars.dart';

class ScrapController extends GetxController {
  var records = <Record>[].obs;
  var selectedBomItem = Rx<BomItems?>(null);
  var quantityController = TextEditingController();
  var currentQtyController = TextEditingController();
  var descriptionController = TextEditingController();

  void addRecord() {
    if (selectedBomItem.value != null && quantityController.text.isNotEmpty) {
      var newRecord = Record(
        dropdownValue: selectedBomItem.value!.materialName?.toString() ?? "",
        itemId: selectedBomItem.value!.materialId?.toString() ?? "",
        itemName: selectedBomItem.value!.materialName?.toString() ?? "",
        categoryId: selectedBomItem.value!.categoryId?.toString() ?? "",
        categoryName: selectedBomItem.value!.categoryName?.toString() ?? "",
        bomItemId: selectedBomItem.value!.id?.toString() ?? "",
        quantity: quantityController.text,
        currentQty: currentQtyController.text,
        description: descriptionController.text,
      );
      records.add(newRecord);

      quantityController.clear();
      currentQtyController.clear();
      descriptionController.clear();
      selectedBomItem.value = null;
      FocusManager.instance.primaryFocus?.unfocus();

    } else {
      Open.openDateErrorSnackbar("Fill Required Fields");
    }
  }

  void onBomItemSelected(BomItems? newValue) {
    selectedBomItem.value = newValue;
    currentQtyController.text = selectedBomItem.value!.quantity?.toString() ?? "";
    quantityController.clear();
    descriptionController.clear();
  }

  void deleteRecord(int index) {
    records.removeAt(index);
  }

  void clearAll() {
    records = <Record>[].obs;
    selectedBomItem = Rx<BomItems?>(null);
    quantityController = TextEditingController();
    currentQtyController = TextEditingController();
    descriptionController = TextEditingController();
  }

  Map<String,dynamic> payload() {
    final i = Get.put(PORecordCtrl());
    return {
      "productionStagesId": i.activeStage.value.id,
      "inspector": [i.activeStage.value.inspector],
      "isScrapMaterialEnable": true,
      "isAddOnMaterialEnable": false,
      "isStageCompleted": false,
      "scrapMaterial": records.map((i) {
        return {
          "bomItemId": i.bomItemId,
          "itemId": i.itemId,
          "categoryName": i.categoryName,
          "itemName": i.itemName,
          "currentStock": convertToNumber(i.currentQty),
          "categoryId": i.categoryId,
          "scrapStock": i.quantity,
        };
      }).toList(),
    };
  }

  num? convertToNumber(dynamic value) {
    double? number = double.tryParse(value.toString());
    if (number != null) {
      if (number == number.toInt()) {
        return number.toInt();
      } else {
        return number;
      }
    } else {
      return null;
    }
  }

}

class Record {
  final String dropdownValue;
  final String itemId;
  final String itemName;
  final String bomItemId;
  final String categoryId;
  final String categoryName;
  final String quantity;
  final String currentQty;
  final String description;

  Record({
    required this.dropdownValue,
    required this.itemId,
    required this.itemName,
    required this.bomItemId,
    required this.categoryId,
    required this.categoryName,
    required this.quantity,
    required this.currentQty,
    required this.description,
  });
}