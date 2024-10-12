import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../api/Models/POModel.dart';

class PageControllerGetX extends GetxController {
  final PageController pageController = PageController();
  List<ProductionStages>? items = [];
  var currentPage = 0.obs;

  // Navigate to the next page
  void nextPage() {
    if (currentPage.value < items!.length - 1) {
      pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  // Navigate to the previous page
  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  // Update page index on swipe
  void onPageChanged(int index) {
    currentPage.value = index;
  }
}
