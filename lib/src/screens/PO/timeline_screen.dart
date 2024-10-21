
import 'package:dealsify_production/src/screens/PO/po_view.dart';
import 'package:dealsify_production/src/state_controllers/production_order_states.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import '../../../core/colors_and_icons/images.dart';
import '../../common_functions/animations.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  final record = Get.put(PORecordCtrl());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigateToPage(context, const ProductionOrderView());
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
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontFamily: FontFamily.boldMulish,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${record.activeStage.value.label}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: FontFamily.regularMulish,
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
              navigateToPage(context, const ProductionOrderView());
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black87,
            ),
          ),
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                  "Coming soon!",
                style: TextStyle(
                  fontFamily: FontFamily.regularMulish,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
