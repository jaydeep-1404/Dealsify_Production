import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/Models/POModel.dart';

class DateTimeController extends GetxController {
  var startDate = DateTime.now().obs;
  var startTime = TimeOfDay.now().obs;
  var endDate = DateTime.now().obs;
  var endTime = TimeOfDay.now().obs;

  void pickStartDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: startDate.value,
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
      initialTime: startTime.value,
    );
    if (pickedTime != null) {
      startTime.value = pickedTime;
    }
  }

  void pickEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: endDate.value,
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
      initialTime: endTime.value,
    );
    if (pickedTime != null) {
      endTime.value = pickedTime;
    }
  }

}

class PageControllerGetX extends GetxController {
  final PageController pageController = PageController();
  List<ProductionStages>? items = [];
  List<int>? completeStages = [];
  var currentPage = 0.obs;
  var startDates = <dynamic>[].obs;
  var endDates = <dynamic>[].obs;
  var startTimes = <dynamic>[].obs;
  var endTimes = <dynamic>[].obs;

  PageControllerGetX() {
    startDates.value = List.generate(items!.length, (index) => null);
    endDates.value = List.generate(items!.length, (index) => null);
    startTimes.value = List.generate(items!.length, (index) => null);
    endTimes.value = List.generate(items!.length, (index) => null);
  }

  setDateLength(index){
    startDates.value = List.generate(index, (index) => null);
    endDates.value = List.generate(index, (index) => null);
    startTimes.value = List.generate(index, (index) => null);
    endTimes.value = List.generate(index, (index) => null);
  }

  void addToCompletedItems(index){
    print("CURRENT PAGE : $index");
    completeStages!.add(index);
    print("COMPLETED : ${completeStages!.length}");
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
    DateTime? startDate = startDates[index];
    DateTime? endDate = endDates[index];
    TimeOfDay? startTime = startTimes[index];
    TimeOfDay? endTime = endTimes[index];
    return {
      "productionStagesId": item.id.toString(),
      "inspector": item.inspector.toString(),
      "isScrapMaterialEnable": false,
      "isAddOnMaterialEnable": false,
      "isStageCompleted": true,
      "startingTime": startTime?.hour == null || startTime?.minute == null ? "" : "${startTime?.hour ?? ''}:${startTime?.minute ?? ''}:00",
      "startingDate": startDate?.toString() ?? "",
      "endingTime": endTime?.hour == null || endTime?.minute == null ? "" : "${endTime?.hour}:${endTime?.minute}:00",
      "endingDate": endDate?.toString() ?? "",
    };
  }
}
