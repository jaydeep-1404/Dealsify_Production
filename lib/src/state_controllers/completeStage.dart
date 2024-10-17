import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/Models/bomItems.dart';

class StageController extends GetxController {
  var startDate = Rxn<DateTime>();
  var startTime = Rxn<TimeOfDay>();
  var endDate = Rxn<DateTime>();
  var endTime = Rxn<TimeOfDay>();

  void pickStartDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      startDate.value = pickedDate;
    }
  }

  void pickStartTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      startTime.value = pickedTime;
    }
  }

  void pickEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      endDate.value = pickedDate;
    }
  }

  void pickEndTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      endTime.value = pickedTime;
    }
  }

  void saveData() {
    if (startDate.value == null) {
      Get.snackbar(
        'Error',
        'Please select a start date',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (endDate.value == null) {
      Get.snackbar(
        'Error',
        'Please select an end date',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      // Data is valid, perform saving action
      Get.snackbar(
        'Success',
        'Data saved successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void clearAll(){
    startDate = Rxn<DateTime>();
    startTime = Rxn<TimeOfDay>();
    endDate = Rxn<DateTime>();
    endTime = Rxn<TimeOfDay>();
  }

}

class ScrapController extends GetxController {
  var records = <Record>[].obs;

  var selectedBomItem = Rx<BomItems?>(null);
  var quantityController = TextEditingController();
  var currentQtyController = TextEditingController(text: '10');
  var descriptionController = TextEditingController();

  void addRecord() {
    if (selectedBomItem.value != null &&
        quantityController.text.isNotEmpty) {
      var newRecord = Record(
        dropdownValue: "",
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
      Get.snackbar('Error', 'Please fill all fields',
          snackPosition: SnackPosition.BOTTOM);
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
}

class Record {
  final String dropdownValue;
  final String quantity;
  final String currentQty;
  final String description;

  Record({
    required this.dropdownValue,
    required this.quantity,
    required this.currentQty,
    required this.description,
  });
}
