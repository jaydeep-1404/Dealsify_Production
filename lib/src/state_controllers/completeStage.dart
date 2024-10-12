import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/Models/POModel.dart';

class PageControllerGetX extends GetxController {
  final PageController pageController = PageController();
  List<ProductionStages>? items = [];
  var currentPage = 0.obs;
  var startDates = <DateTime>[].obs;
  var endDates = <DateTime>[].obs;
  var startTimes = <TimeOfDay>[].obs;
  var endTimes = <TimeOfDay>[].obs;

  PageControllerGetX() {
    startDates.value = List.generate(items!.length, (index) => DateTime.now());
    endDates.value = List.generate(items!.length, (index) => DateTime.now());
    startTimes.value = List.generate(items!.length, (index) => TimeOfDay.now());
    endTimes.value = List.generate(items!.length, (index) => TimeOfDay.now());
  }

  setDateLength(index){
    startDates.value = List.generate(index, (index) => DateTime.now());
    endDates.value = List.generate(index, (index) => DateTime.now());
    startTimes.value = List.generate(index, (index) => TimeOfDay.now());
    endTimes.value = List.generate(index, (index) => TimeOfDay.now());
  }

  void updateStartDate(int index, DateTime date) {
    startDates[index] = date;
    update();
  }

  void updateEndDate(int index, DateTime date) {
    endDates[index] = date;
    update();
  }

  void updateStartTime(int index, TimeOfDay time) {
    startTimes[index] = time;
    update();
  }

  void updateEndTime(int index, TimeOfDay time) {
    endTimes[index] = time;
    update();
  }

  void nextPage() {
    if (currentPage.value < items!.length - 1) {
      pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  Map<String, dynamic> payload(index,context) {
    final item = items![index];
    final startDate = startDates[index];
    final endDate = endDates[index];
    final startTime = startTimes[index];
    final endTime = endTimes[index];
    return {
      // "productionStagesId": "67092b4f774fefc0bdf7970a",
      // "inspector": "Satish patar",
      // "isScrapMaterialEnable": false,
      // "isAddOnMaterialEnable": false,
      // "isStageCompleted": false,
      // "startingTime": "07:00:00",
      // "startingDate": "2024-10-12T18:30:00.000Z",
      // "endingTime": "07:00:00",
      // "endingDate": "2024-10-12T18:30:00.000Z"

      "productionStagesId": item.stageId.toString(),
      "inspector": item.inspector.toString(),
      "isScrapMaterialEnable": false,
      "isAddOnMaterialEnable": false,
      "isStageCompleted": false,
      "startingTime": "${startTime.hour}:${startTime.minute}:00",
      "startingDate": startDate.toString(),
      "endingTime": "${endTime.hour}:${endTime.minute}:00",
      "endingDate": endDate.toString()
    };
  }
}
