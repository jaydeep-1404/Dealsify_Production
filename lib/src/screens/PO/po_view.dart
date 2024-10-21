import 'dart:io';

import 'package:dealsify_production/core/colors_and_icons/colors.dart';
import 'package:dealsify_production/core/services/extensions.dart';
import 'package:dealsify_production/src/common_functions/animations.dart';
import 'package:dealsify_production/src/screens/PO/purchase_orders.dart';
import 'package:dealsify_production/src/screens/PO/scrap_screen.dart';
import 'package:dealsify_production/src/screens/PO/timeline_screen.dart';
import 'package:dealsify_production/src/state_controllers/scrap_controller.dart';
import 'package:dealsify_production/src/state_controllers/stage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../api/post/comlete_stage.dart';
import '../../../core/colors_and_icons/images.dart';
import '../../common_functions/snackbars.dart';
import '../../state_controllers/production_order_states.dart';

class ProductionOrderView extends StatefulWidget {
  const ProductionOrderView({super.key});

  @override
  State<ProductionOrderView> createState() => _ProductionOrderViewState();
}

class _ProductionOrderViewState extends State<ProductionOrderView> {
  final record = Get.put(PORecordCtrl());
  final stageController = Get.put(StageController());
  final scrapController = Get.put(ScrapController());
  final save = Get.put(CompleteStageController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void clearData(){
    record.clearAll();
    stageController.clearAll();
    scrapController.clearAll();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        clearData();
        navigateToPage(context, const DashboardScreen());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${record.poRecord.value.items!.itemName}',
                  maxLines: 3,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontFamily: FontFamily.boldMulish,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${record.activeStage.value.label}',
                  maxLines: 3,
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: FontFamily.boldMulish,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black87,
                  ),
                ),
              ],
            );
          }),
          toolbarHeight: 80,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              clearData();
              navigateToPage(context, const DashboardScreen());
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black87,
            ),
          ),
        ),
        body: Obx(() {
          final stage = record.activeStage.value;

          String getInspectorDisplay(dynamic inspector) {
            if (inspector is String) {
              return inspector;
            } else if (inspector is List) {
              return inspector.join(', ');
            }
            return '';
          }

          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  Text(
                    'Flore Inspector : ${getInspectorDisplay(stage.inspector)}',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontFamily: FontFamily.regularMulish,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  buildDateTimePicker(
                    loading: save.loadingStart.value,
                    onSave: () {
                      if (save.loadingStart.value != true){
                        if (stageController.startDate.value == null) {
                          Open.openDateErrorSnackbar("Select Start Date");
                        } else {
                          stageController.payloadStartStage().printFormattedJson();
                          save.post(
                            isStart: true,
                            record.poRecord.value.id,
                            stageController.payloadStartStage(),
                            context,
                          );
                        }
                      }
                    },
                    context,
                    'Start Date', 'Start Time',
                    stageController.startDate.value, () => stageController.pickStartDate(context),
                    stageController.startTime.value, () => stageController.pickStartTime(context),
                  ),
                  const SizedBox(height: 10),
                  buildDateTimePicker(
                    loading: save.loadingEnd.value,
                    onSave: () {
                      if (save.loadingEnd.value != true){
                        if (stageController.startDate.value == null) {
                          Open.openDateErrorSnackbar("Select Start Date");
                        } else if (stageController.endDate.value == null) {
                          Open.openDateErrorSnackbar("Select End Date");
                        } else {
                          stageController.payloadEndStage().printFormattedJson();
                          save.post(
                            isEnd: true,
                            record.poRecord.value.id,
                            stageController.payloadEndStage(),
                            context,
                          );
                        }
                      }
                    },
                    context,
                    'End Date', 'End Time',
                    stageController.endDate.value, () => stageController.pickEndDate(context),
                    stageController.endTime.value, () => stageController.pickEndTime(context),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            navigateToPage(context, const TimelineScreen());
                          },
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            decoration: BoxDecoration(
                              // color: Color(0xffd4e0e3),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: green_high,width: 1.5)
                            ),
                            child: const Center(
                              child: Row(
                                children: [
                                  Icon(Icons.timelapse,color: green_high,size: 18,),
                                  SizedBox(width: 5),
                                  Text(
                                      "Timeline",
                                      style: TextStyle(
                                        color: green_high,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontFamily.regularMulish,
                                      ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            navigateToPage(context, const ScrapScreen());
                          },
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: green_high,width: 1.5)
                            ),
                            child: const Center(
                              child: Row(
                                children: [
                                  Icon(Icons.add,color: green_high,size: 17,),
                                  SizedBox(width: 5),
                                  Text(
                                    "Add Scrap",
                                    style: TextStyle(
                                      color: green_high,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontFamily.regularMulish,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // ElevatedButton.icon(
                        //   onPressed: () {
                        //     navigateToPage(context, const TimelineScreen());
                        //   },
                        //   icon: const Icon(Icons.timelapse, color: Colors.black87),
                        //   label: const Text(
                        //       "Timeline",
                        //       style: TextStyle(
                        //         color: Colors.black87,
                        //         fontWeight: FontWeight.bold,
                        //         fontFamily: FontFamily.regularMulish,
                        //       )),
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: const Color(0xFFBBDEFB), // Light Blue
                        //     // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //
                        //   ),
                        // ),
                        // ElevatedButton.icon(
                        //   onPressed: () {
                        //     navigateToPage(context, const ScrapScreen());
                        //   },
                        //   icon: const Icon(Icons.add, color: Colors.black87),
                        //   label: const Text(
                        //       "Add Scrap",
                        //       style: TextStyle(
                        //         color: Colors.black87,
                        //         fontWeight: FontWeight.bold,
                        //         fontFamily: FontFamily.regularMulish,
                        //       )
                        //   ),
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: const Color(0xFFBBDEFB), // Light Blue
                        //     // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              completeButton(
                loading: save.loadingComplete.value,
                onTap: (){
                  if (stageController.startDate.value == null) {
                    Open.openDateErrorSnackbar("Select Start Date");
                  } else if (stageController.endDate.value == null) {
                    Open.openDateErrorSnackbar("Select End Date");
                  } else {
                    stageController.payloadCompleteStage().printFormattedJson();
                    save.post(
                      isComplete: true,
                      record.poRecord.value.id,
                      stageController.payloadCompleteStage(),
                      context,
                    );
                  }
                }
              ),
            ],
          );
        }),
      ),
    );
  }
}

Widget completeButton({onTap,loading}){
  return Positioned(
    bottom: Platform.isIOS ? 40 : 30,
    left: 0,
    right: 0,
    child: GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        height: 35,
        width: Get.width / 1.2,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.green.shade700,
          // color: Colors.green.shade100,
          border: Border.all(color: green_high),
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
          child: loading == true ? const SizedBox(height: 20,width: 20,child: CircularProgressIndicator(strokeWidth: 1.5,)) : const Text(
            'Complete',
            style: TextStyle(
              color: Colors.white,
              fontFamily: FontFamily.regularMulish,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildDateTimePicker(
    BuildContext context,
    String label,
    String label2,
    DateTime? date,
    VoidCallback onDateTapped,
    TimeOfDay? time,
    VoidCallback onTimeTapped,{
      void Function()? onSave,
      loading,
    }
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
                      Text(
                          label,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: FontFamily.regularMulish,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                          "*",
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontFamily: FontFamily.regularMulish,
                            fontSize: 15,
                          )),
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
                        style: TextStyle(
                          color: date == null ? Colors.grey.shade600 : Colors.black,
                          fontFamily: FontFamily.regularMulish,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      label2,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: FontFamily.regularMulish,
                        fontWeight: FontWeight.bold,
                      )),
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
                        style: TextStyle(
                          color: time == null ? Colors.grey.shade600 : Colors.black,
                          fontFamily: FontFamily.regularMulish,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onSave ?? () {},
                child: Container(
                  height: 35,
                  width: Get.width * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(6),
                    // border: Border.all(
                      // color: pink_high,
                      // width: 1,
                    // ),
                  ),
                  child: Center(
                    child: loading == true ? const SizedBox(height: 20,width: 20,child: CircularProgressIndicator(strokeWidth: 1.5,)) : const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: FontFamily.regularMulish,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

