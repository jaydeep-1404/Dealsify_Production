
import 'package:dealsify_production/api/Models/bomItems.dart';
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
        categoryId: selectedBomItem.value!.categoryId?.toString() ?? "",
        bomItemId: selectedBomItem.value!.groupId?.toString() ?? "",
        quantity: quantityController.text,
        currentQty: currentQtyController.text,
        description: descriptionController.text,
      );
      records.add(newRecord);

      quantityController.clear();
      currentQtyController.clear();
      descriptionController.clear();
      selectedBomItem.value = null;
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

  void clearAll(){
    records = <Record>[].obs;
    selectedBomItem = Rx<BomItems?>(null);
    quantityController = TextEditingController();
    currentQtyController = TextEditingController();
    descriptionController = TextEditingController();
  }
}

class Record {
  final String dropdownValue;
  final String itemId;
  final String bomItemId;
  final String categoryId;
  final String quantity;
  final String currentQty;
  final String description;

  Record({
    required this.dropdownValue,
    required this.itemId,
    required this.bomItemId,
    required this.categoryId,
    required this.quantity,
    required this.currentQty,
    required this.description,
  });
}