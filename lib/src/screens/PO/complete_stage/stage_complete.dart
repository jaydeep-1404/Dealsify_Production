
import 'package:dealsify_production/core/services/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../api/post/comlete_stage.dart';
import '../../../state_controllers/completeStage.dart';
import '../../../state_controllers/production_order_states.dart';

class OpenBillingAddress extends StatelessWidget {
  final index;
  OpenBillingAddress({super.key, this.index});
  final record = Get.put(PORecordCtrl());
  final controller = Get.put(PageControllerGetX());
  final saveStage = Get.put(CompleteStageController());

  @override
  Widget build(BuildContext context) {
    final item = record.poRecord.items![index];
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
            height: Get.height * 0.5,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(13),topRight: Radius.circular(13))
            ),
            child: Column(
              mainAxisAlignment:MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: SizedBox(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          children: [
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 350,
                              width: double.infinity,
                              child: PageView.builder(
                                controller: controller.pageController,
                                itemCount: controller.items!.length,
                                onPageChanged: controller.onPageChanged,
                                itemBuilder: (context, index) {
                                  final i = controller.items![index];
                                  return Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Customer Name : ${record.poRecord.customerId!.shortName.toString()}"),
                                        Text("Item : ${item.itemName}"),
                                        Text("Stage : ${i.label}"),
                                        Text("Inspector : ${i.inspector}"),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Obx(() {
                                              return Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  datePicker(
                                                    label: "Start date",
                                                    msg: controller.startDates[index].toLocal().toString().split(' ')[0],
                                                    onTap:() async {
                                                      DateTime? pickedDate = await showDatePicker(
                                                        context: context,
                                                        initialDate: controller.startDates[index],
                                                        firstDate: DateTime(2000),
                                                        lastDate: DateTime(2100),
                                                      );
                                                      if (pickedDate != null) {
                                                        controller.updateStartDate(index, pickedDate);
                                                      }
                                                    },
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  timePicker(
                                                    label: "Start time",
                                                    msg: controller.startTimes[index].format(context),
                                                    onTap:() async {
                                                      final TimeOfDay? picked = await showTimePicker(
                                                        context: context,
                                                        initialTime: controller.startTimes[index],
                                                      );
                                                      if (picked != null) {
                                                        controller.updateStartTime(index, picked);
                                                      }
                                                    },
                                                  ),
                                                ],);
                                            },),
                                            Obx(() {
                                              return Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  datePicker(
                                                    label: "End date",
                                                    msg: controller.endDates[index].toLocal().toString().split(' ')[0],
                                                    onTap:() async {
                                                      DateTime? pickedDate = await showDatePicker(
                                                        context: context,
                                                        initialDate: controller.endDates[index],
                                                        firstDate: DateTime(2000),
                                                        lastDate: DateTime(2100),
                                                      );
                                                      if (pickedDate != null) {
                                                        controller.updateEndDate(index, pickedDate);
                                                      }
                                                    },
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  timePicker(
                                                    label: "End date",
                                                    msg: controller.endTimes[index].format(context),
                                                    onTap:() async {
                                                      final TimeOfDay? picked = await showTimePicker(
                                                        context: context,
                                                        initialTime: controller.endTimes[index],
                                                      );
                                                      if (picked != null) {
                                                        controller.updateEndTime(index, picked);
                                                      }
                                                    },
                                                  ),
                                                ],);
                                            },),
                                          ],
                                        ),

                                        const SizedBox(height: 10),
                                        saveButton(
                                          onPressed: () {
                                            controller.payload(index, context).printFormattedJson();
                                            saveStage.post(record.poRecord.id,controller.payload(index, context));
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            saveAndNextButton(
                              onCancel: () {
                                Get.back();
                                controller.dispose();
                              },
                              onNext: () {
                                controller.currentPage.value < controller.items!.length - 1
                                    ? controller.nextPage()
                                    : null;
                              },
                            ),
                          ],
                        )
                    )
                )
              ],),
          ),
        );
      },
    );
  }

  Widget datePicker({void Function()? onTap,msg,label}){
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${label ?? ''}'),
          Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black,width: 1),
            ),
            child: Center(
              child: Text("$msg"),
            ),
          ),
        ],
      ),
    );
  }

  Widget timePicker({void Function()? onTap,msg,label}){
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${label ?? ''}'),
          Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black,width: 1),
            ),
            child: Center(
              child: Text("$msg"),
            ),
          ),
        ],
      ),
    );
  }

  Widget saveAndNextButton({required Null Function() onCancel,required Null Function() onNext}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: onCancel,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(),
              shape: const ContinuousRectangleBorder(),
              backgroundColor: Colors.grey[300],
            ),
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: onNext,
          style: ElevatedButton.styleFrom(
            shape: const ContinuousRectangleBorder(),
            backgroundColor: Colors.blueAccent,
          ),
          child: const Text(
            "Next",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }


  Widget saveButton({required Null Function() onPressed,label}){
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.only(),
          shape: const ContinuousRectangleBorder(),
          backgroundColor: Colors.blueAccent,
        ),
        child: Text(
          "${label ?? "Save"}",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

}
