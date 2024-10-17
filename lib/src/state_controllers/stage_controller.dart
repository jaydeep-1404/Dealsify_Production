import 'package:dealsify_production/src/state_controllers/production_order_states.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  Map<String,dynamic> payloadStartStage() {
    final i = Get.put(PORecordCtrl());
    return {
      "productionStagesId": i.activeStage.value.id,
      "inspector": i.activeStage.value.inspector,
      "isScrapMaterialEnable": false,
      "isAddOnMaterialEnable": false,
      "isStageCompleted": false,
      if (startTime.value != null)"startingTime": "${startTime.value!.hour}:${startTime.value!.minute}:00",
      "startingDate": startDate.value.toString(),
    };
  }

  Map<String,dynamic> payloadEndStage() {
    final i = Get.put(PORecordCtrl());
    return {
      "productionStagesId": i.activeStage.value.id,
      "inspector": i.activeStage.value.inspector,
      "isScrapMaterialEnable": false,
      "isAddOnMaterialEnable": false,
      "isStageCompleted": false,
      if (startTime.value != null)"startingTime": "${startTime.value!.hour}:${startTime.value!.minute}:00",
      "startingDate": startDate.value.toString(),
      if (endTime.value != null)"endingTime": "${endTime.value!.hour}:${endTime.value!.minute}:00",
      "endingDate": endDate.value.toString(),
    };
  }

  Map<String,dynamic> payloadCompleteStage() {
    return {
      "productionStagesId": "65b345cd97f3f76bcc37741f",
      "inspector": "Satish",
      "isScrapMaterialEnable": false,
      "isAddOnMaterialEnable": false,
      "isStageCompleted": true,
      if (startTime.value != null)"startingTime": "${startTime.value!.hour}:${startTime.value!.minute}:00",
      "startingDate": startDate.value.toString(),
      if (endTime.value != null)"endingTime": "${endTime.value!.hour}:${endTime.value!.minute}:00",
      "endingDate": endDate.value.toString(),
    };
  }

  void clearAll(){
    startDate = Rxn<DateTime>();
    startTime = Rxn<TimeOfDay>();
    endDate = Rxn<DateTime>();
    endTime = Rxn<TimeOfDay>();
  }

}


