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

  void setStartDateTime(String dateString, String timeString) {
    if (dateString.isNotEmpty){
      try {
        DateTime parsedDate = DateTime.parse(dateString);
        startDate.value = parsedDate;
      } catch (e) {
        print("$e");
      }
    }
    if (timeString.isNotEmpty){
      try {
        List<String> timeParts = timeString.split(':');
        if (timeParts.length == 3) {
          int hour = int.parse(timeParts[0]);
          int minute = int.parse(timeParts[1]);
          startTime.value = TimeOfDay(hour: hour, minute: minute);
        }
      } catch (e, s) {
        print(s);
      }
    }
  }

  void setEndDateTime(String dateString, String timeString) {
    if (dateString.isNotEmpty){
      try {
        DateTime parsedDate = DateTime.parse(dateString);
        endDate.value = parsedDate;
      } catch (e) {
        print("$e");
      }
    }
    if (timeString.isNotEmpty){
      try {
        List<String> timeParts = timeString.split(':');
        if (timeParts.length == 3) {
          int hour = int.parse(timeParts[0]);
          int minute = int.parse(timeParts[1]);
          endTime.value = TimeOfDay(hour: hour, minute: minute);
        }
      } catch (e, s) {
        print(s);
      }
    }
  }



  Map<String, dynamic> payloadStartStage() {
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

  Map<String, dynamic> payloadEndStage() {
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

  Map<String, dynamic> payloadCompleteStage() {
    final i = Get.put(PORecordCtrl());
    return {
      "productionStagesId": i.activeStage.value.id,
      "inspector": i.activeStage.value.inspector,
      "isScrapMaterialEnable": false,
      "isAddOnMaterialEnable": false,
      "isStageCompleted": true,
      if (startTime.value != null)"startingTime": "${startTime.value!.hour}:${startTime.value!.minute}:00",
      "startingDate": startDate.value.toString(),
      if (endTime.value != null)"endingTime": "${endTime.value!.hour}:${endTime.value!.minute}:00",
      "endingDate": endDate.value.toString(),
    };
  }

  void clearAll() {
    startDate.value = null;
    startTime.value = null;
    endDate.value = null;
    endTime.value = null;
  }
}