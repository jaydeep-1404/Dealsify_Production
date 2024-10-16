import 'package:dealsify_production/src/common_functions/animations.dart';
import 'package:dealsify_production/src/screens/PO/purchase_orders.dart';
import 'package:dealsify_production/src/screens/PO/scrap_screen.dart';
import 'package:dealsify_production/src/state_controllers/completeStage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_controllers/production_order_states.dart';

class ProductionOrderView extends StatefulWidget {
  const ProductionOrderView({super.key});

  @override
  State<ProductionOrderView> createState() => _ProductionOrderViewState();
}

class _ProductionOrderViewState extends State<ProductionOrderView> {
  final record = Get.put(PORecordCtrl());
  final stageController = Get.put(StageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${record.poRecord.value.items!.first.itemName}',
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${record.activeStage.value.label}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          );
        }),
        toolbarHeight: 80,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            navigateToPage(context, const DashboardScreen());
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      body: Obx(() {
        final stage = record.activeStage.value;
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            Text(
              'Inspector: ${stage.inspector ?? ''}',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            buildDateTimePicker(
              onSave: () {
                if (stageController.startDate.value == null) {
                  openDateErrorSnackbar();
                } else {
                }
              },
              onComplete: () {
                if (stageController.startDate.value == null) {
                  openDateErrorSnackbar();
                } else {
                }
              },
              context,
              'Start date', 'Start time',
              stageController.startDate.value,
                  () => stageController.pickStartDate(context),
              stageController.startTime.value,
                  () => stageController.pickStartTime(context),
            ),
            const SizedBox(height: 10),
            buildDateTimePicker(
              onSave: () {
                if (stageController.endDate.value == null) {
                  openDateErrorSnackbar();
                } else {
                }
              },
              onComplete: () {
                if (stageController.endDate.value == null) {
                  openDateErrorSnackbar();
                } else {
                  // Complete logic here
                }
              },
              context,
              'End date', 'End time',
              stageController.endDate.value,
                  () => stageController.pickEndDate(context),
              stageController.endTime.value,
                  () => stageController.pickEndTime(context),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  navigateToPage(context, const ScrapScreen());
                },
                icon: const Icon(Icons.delete, color: Colors.black87),
                label: const Text("Scrap", style: TextStyle(color: Colors.black87)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBBDEFB), // Light Blue
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

 openDateErrorSnackbar() {
  return Get.snackbar(
    'Error',
    'Please select a date',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.redAccent,
    colorText: Colors.white,
  );
}

Widget buildDateTimePicker(
    BuildContext context,
    String label,
    String label2,
    DateTime? date,
    VoidCallback onDateTapped,
    TimeOfDay? time,
    VoidCallback onTimeTapped,{void Function()? onSave,void Function()? onComplete}
    ) {
  return Material(
    elevation: 2,
    borderRadius: BorderRadius.circular(10),
    child: Container(
      padding: const EdgeInsets.only(
        top: 10, bottom: 5, left: 10, right: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("*", style: TextStyle(color: Colors.red.shade700,fontSize: 15)),
                    ],
                  ),
                  GestureDetector(
                    onTap: onDateTapped,
                    child: Container(
                      height: 35,
                      width: Get.width / 2.8,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        (date == null) ? "Select date..." : "${date.day}-${date.month}-${date.year}",
                        style: TextStyle(color: date == null ? Colors.grey : Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label2, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: onTimeTapped,
                    child: Container(
                      height: 35,
                      width: Get.width / 2.8,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        (time == null) ? "Select time..." : "${time.hour}:${time.minute}",
                        style: TextStyle(color: time == null ? Colors.grey : Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10,),
          buildSaveCompleteButton(
            onSave: onSave ?? () {},
            onComplete: onComplete ??() {},
          ),
        ],
      ),
    ),
  );
}

Widget buildDateTimeField(String label, dynamic value, VoidCallback onTapped) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      GestureDetector(
        onTap: onTapped,
        child: Container(
          height: 40,
          width: Get.width / 2.8,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            (value == null) ? "Select..." : "${value.day}-${value.month}-${value.year}",
            style: TextStyle(color: value == null ? Colors.grey : Colors.black),
          ),
        ),
      ),
    ],
  );
}

Widget buildSaveCompleteButton({void Function()? onSave, void Function()? onComplete}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: onSave ?? () {},
        child: Container(
          height: 35,
          width: Get.width * 0.3,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.blue.shade700,
              width: 1,
            ),
          ),
          child: const Center(
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: onComplete ?? () {},
        child: Container(
          height: 35,
          width: Get.width * 0.3,
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            border: Border.all(color: Colors.green.shade700),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Complete',
              style: TextStyle(
                color: Colors.green.shade700,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}