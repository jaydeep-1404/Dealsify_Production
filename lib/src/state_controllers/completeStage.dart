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

  // Method to pick the start time
  void pickStartTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      startTime.value = pickedTime;
    }
  }

  // Method to pick the end date
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

  // Method to pick the end time
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
}

class ScrapController extends GetxController {
  var records = <Record>[].obs;

  var selectedBomItem = Rx<BomItems?>(null);
  var quantityController = TextEditingController();
  var currentQtyController = TextEditingController(text: '10'); // Example of pre-filled current qty
  var descriptionController = TextEditingController();

  void addRecord() {
    if (selectedBomItem.value != null &&
        quantityController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      var newRecord = Record(
        dropdownValue: "",
        quantity: quantityController.text,
        currentQty: currentQtyController.text,
        description: descriptionController.text,
      );
      records.add(newRecord);

      quantityController.clear();
      descriptionController.clear();
      selectedBomItem.value = null;
    } else {
      Get.snackbar('Error', 'Please fill all fields',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void onBomItemSelected(BomItems? newValue) {
    selectedBomItem.value = newValue;
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

// class PageControllerGetX extends GetxController {
//   final PageController pageController = PageController();
//   List<ProductionStages>? items = [];
//   List<int>? completeStages = [];
//   var currentPage = 0.obs;
//   var startDates = <dynamic>[].obs;
//   var endDates = <dynamic>[].obs;
//   var startTimes = <dynamic>[].obs;
//   var endTimes = <dynamic>[].obs;
//
//   PageControllerGetX() {
//     startDates.value = List.generate(items!.length, (index) => null);
//     endDates.value = List.generate(items!.length, (index) => null);
//     startTimes.value = List.generate(items!.length, (index) => null);
//     endTimes.value = List.generate(items!.length, (index) => null);
//   }
//
//   setDateLength(index){
//     startDates.value = List.generate(index, (index) => null);
//     endDates.value = List.generate(index, (index) => null);
//     startTimes.value = List.generate(index, (index) => null);
//     endTimes.value = List.generate(index, (index) => null);
//   }
//
//   void addToCompletedItems(index){
//     print("CURRENT PAGE : $index");
//     completeStages!.add(index);
//     print("COMPLETED : ${completeStages!.length}");
//   }
//
//   void updateStartDate(int index, DateTime date) {
//     startDates[index] = date;
//     update();
//   }
//
//   void updateEndDate(int index, DateTime date) {
//     endDates[index] = date;
//     update();
//   }
//
//   void updateStartTime(int index, TimeOfDay time) {
//     startTimes[index] = time;
//     update();
//   }
//
//   void updateEndTime(int index, TimeOfDay time) {
//     endTimes[index] = time;
//     update();
//   }
//
//   void nextPage() {
//     if (currentPage.value < items!.length - 1) {
//
//       pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
//     }
//   }
//
//   void previousPage() {
//     if (currentPage.value > 0) {
//       pageController.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
//     }
//   }
//
//   void onPageChanged(int index) {
//     currentPage.value = index;
//   }
//
//   Map<String, dynamic> payload(index,context) {
//     final item = items![index];
//     DateTime? startDate = startDates[index];
//     DateTime? endDate = endDates[index];
//     TimeOfDay? startTime = startTimes[index];
//     TimeOfDay? endTime = endTimes[index];
//     return {
//       "productionStagesId": item.id.toString(),
//       "inspector": item.inspector.toString(),
//       "isScrapMaterialEnable": false,
//       "isAddOnMaterialEnable": false,
//       "isStageCompleted": true,
//       "startingTime": startTime?.hour == null || startTime?.minute == null ? "" : "${startTime?.hour ?? ''}:${startTime?.minute ?? ''}:00",
//       "startingDate": startDate?.toString() ?? "",
//       "endingTime": endTime?.hour == null || endTime?.minute == null ? "" : "${endTime?.hour}:${endTime?.minute}:00",
//       "endingDate": endDate?.toString() ?? "",
//     };
//   }
// }
