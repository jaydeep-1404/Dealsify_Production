
import 'package:dealsify_production/core/services/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../api/get/get_po_list.dart';
import '../../../../api/post/comlete_stage.dart';
import '../../../state_controllers/completeStage.dart';
import '../../../state_controllers/production_order_states.dart';

class StageCompleteBottomSheet extends StatefulWidget {
  final int index;

  const StageCompleteBottomSheet({super.key, required this.index});

  @override
  State<StageCompleteBottomSheet> createState() => _StageCompleteBottomSheetState();
}

class _StageCompleteBottomSheetState extends State<StageCompleteBottomSheet> {
  final record = Get.put(PORecordCtrl());
  final controller = Get.put(PageControllerGetX());
  final saveStage = Get.put(CompleteStageController());

  @override
  Widget build(BuildContext context) {
    final item = record.poRecord.value.items![widget.index];
    final inCompleteStages = item.incompleteStages();
    controller.items = inCompleteStages;
    controller.setDateLength(controller.items!.length);

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: Container(
            height: Get.height * 0.6,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () async {
                            Get.back();
                            controller.completeStages!.clear();
                            controller.currentPage.value = 0;
                            Get.put(PurchaseOrderController()).get();
                            setState(() {
                              record.checkPOAndRefresh();
                              final item = record.poRecord.value.items![widget.index];
                              final inCompleteStages = item.incompleteStages();
                              controller.items = inCompleteStages;
                              controller.setDateLength(controller.items!.length);
                              setState(() {});
                            });
                          },
                          icon: const Icon(Icons.close, color: Colors.red),
                        ),
                      ),
                      SizedBox(
                        height: Get.height/2.5,
                        width: double.infinity,
                        child: PageView.builder(
                          controller: controller.pageController,
                          itemCount: controller.items!.length,
                          onPageChanged: controller.onPageChanged,
                          itemBuilder: (context, index) {
                            final i = controller.items![index];
                            return Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${i.label}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "Item: ${item.itemName}",
                                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          "Inspector: ${i.inspector}",
                                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider(),
                                  const SizedBox(height: 10),
                                  // if (controller.completeStages!.contains(controller.currentPage.value) )...[
                                  //   Align(
                                  //     alignment: Alignment.topRight,
                                  //     child: Container(
                                  //       height: 30,
                                  //       width: 100,
                                  //       decoration: BoxDecoration(
                                  //           color: Colors.green[100],
                                  //           borderRadius: BorderRadius.circular(20),
                                  //           border: Border.all(color: Colors.green,width: 2)
                                  //       ),
                                  //       child: const Center(
                                  //         child: Text(
                                  //           "Completed",
                                  //           style: TextStyle(
                                  //             fontSize: 13,
                                  //             color: Colors.black,
                                  //             fontWeight: FontWeight.w400,
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ],
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(() {
                                        return buildDateTimePicker(
                                          context,
                                          controller.startDates[index], (pickedDate) {
                                          controller.updateStartDate(index, pickedDate);
                                          },
                                          "Start Date",
                                          controller.startTimes[index], (pickedTime) {
                                          controller.updateStartTime(index, pickedTime);
                                          },
                                          "Start Time",
                                          label: "Start",
                                        );
                                      }),
                                      Obx(() {
                                        return buildDateTimePicker(
                                          context,
                                          controller.endDates[index], (pickedDate) {
                                          controller.updateEndDate(index, pickedDate);
                                          },
                                          "End Date",
                                          controller.endTimes[index], (pickedTime) {
                                          controller.updateEndTime(index, pickedTime);
                                          },
                                          "End Time",
                                          label: "End",
                                        );
                                      }),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      buildNavigationButtons(context, controller),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDateTimePicker(BuildContext context, DateTime? date, Function(DateTime) onDatePicked, String dateLabel, TimeOfDay? time, Function(TimeOfDay) onTimePicked, String timeLabel, {required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), // Label for Start/End
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: date ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            onDatePicked(pickedDate!);
          },
          child: Container(
            height: 40,
            width: Get.width/2.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.teal),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.centerLeft,
            child: Text(date != null ? "${date.day}-${date.month}-${date.year}" : dateLabel),
          ),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: time ?? TimeOfDay.now(),
            );
            onTimePicked(pickedTime!);
          },
          child: Container(
            height: 40,
            width: Get.width/2.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.teal),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.centerLeft,
            child: Text(time != null ? time.format(context) : timeLabel),
          ),
        ),
      ],
    );
  }

  Widget buildNavigationButtons(BuildContext context, PageControllerGetX controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            if (controller.currentPage.value > 0) {
              controller.previousPage();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text("Previous", style: TextStyle(color: Colors.black)),
        ),
        ElevatedButton(
          onPressed: () {
            controller.payload(controller.currentPage.value, context).printFormattedJson();
            saveStage.post(
                record.poRecord.value.id,
                controller.payload(controller.currentPage.value, context),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text("Save & Next", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}