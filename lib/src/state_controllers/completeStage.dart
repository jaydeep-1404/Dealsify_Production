import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/Models/POModel.dart';

class PageControllerGetX extends GetxController {
  final PageController pageController = PageController();
  List<ProductionStages>? items = [];
  var currentPage = 0.obs;
  var startDates = <DateTime>[].obs;
  var endDates = <DateTime>[].obs;
  var startTime = <TimeOfDay>[].obs;
  var endTime = <TimeOfDay>[].obs;

  PageControllerGetX() {
    startDates.value = List.generate(items!.length, (index) => DateTime.now());
    endDates.value = List.generate(items!.length, (index) => DateTime.now());
    startTime.value = List.generate(items!.length, (index) => TimeOfDay.now());
    endTime.value = List.generate(items!.length, (index) => TimeOfDay.now());
  }

  setDateLength(index){
    startDates.value = List.generate(index, (index) => DateTime.now());
    endDates.value = List.generate(index, (index) => DateTime.now());
    startTime.value = List.generate(index, (index) => TimeOfDay.now());
    endTime.value = List.generate(index, (index) => TimeOfDay.now());
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
    startTime[index] = time;
    update();
  }

  void updateEndTime(int index, TimeOfDay time) {
    endTime[index] = time;
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
}
