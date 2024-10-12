
import 'package:dealsify_production/core/routs/routs.dart';
import 'package:dealsify_production/src/state_controllers/completeStage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_controllers/production_order_states.dart';

class PoView extends StatefulWidget {
  const PoView({super.key});

  @override
  State<PoView> createState() => _PoViewState();
}

class _PoViewState extends State<PoView> {
  final record = Get.put(PORecordCtrl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: 40,
        leading: IconButton(
          onPressed: () {
            Get.toNamed(ConstRoute.dashboard);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Items"),
            Text("${record.poRecord.customerId!.shortName}",style: const TextStyle(fontSize: 15),),
            Text("${record.poRecord.productionOrderNo}",style: const TextStyle(fontSize: 15),),
            ],
        ),
        centerTitle: false,
        backgroundColor: Colors.blueGrey[300],
      ),
      body: ListView(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: record.poRecord.items!.length,
              itemBuilder: (context, index) {
                final item = record.poRecord.items![index];
                final stage = item.findFirstIncompleteStage();
                return GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Get.bottomSheet(
                      OpenBillingAddress(index: index),
                      isScrollControlled: true,
                      isDismissible: false,
                      backgroundColor: Colors.transparent,
                    );
                  },
                  child: CustomExpansionTile(
                    title: item.itemName.toString(),
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(stage!.label.toString()),
                            Text(stage.isStageCompleted.toString()),
                          ],),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
      ),
    );
  }


}

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const CustomExpansionTile({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        title: Text(title),
        tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
        expandedAlignment: Alignment.centerLeft,
        childrenPadding: const EdgeInsets.all(16.0),
        children: children,
      ),
    );
  }
}


class OpenBillingAddress extends StatelessWidget {

  final index;
  OpenBillingAddress({super.key, this.index});
  final record = Get.put(PORecordCtrl());
  final controller = Get.put(PageControllerGetX());

  @override
  Widget build(BuildContext context) {
    final item = record.poRecord.items![index];
    final firstStage = item.findFirstIncompleteStage();
    final inCompleteStages = item.incompleteStages();
    controller.items = inCompleteStages;
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: Container(
            height: Get.height * 0.7,
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
                            Text("Customer Name : ${record.poRecord.customerId!.shortName.toString()}"),
                            Text(item.itemName.toString()),
                            Text(firstStage!.label.toString()),
                            Text(firstStage.inspector.toString()),
                            const Divider(),
                            Container(
                              height: 300,
                              width: double.infinity,
                              child: PageView.builder(
                                controller: controller.pageController,
                                itemCount: controller.items!.length,
                                onPageChanged: controller.onPageChanged,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color: Colors.blue,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("$index")
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                    controller.dispose();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const ContinuousRectangleBorder(),
                                    backgroundColor: Colors.white70,
                                  ),
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    controller.currentPage.value < controller.items!.length - 1
                                        ? controller.nextPage()
                                        : null;
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const ContinuousRectangleBorder(),
                                    backgroundColor: Colors.blueAccent,
                                  ),
                                  child: const Text("Next"),
                                ),
                            ],)

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
}


// void data (){
//   return Container(
//     margin: const EdgeInsets.all(8),
//     decoration: BoxDecoration(
//       border: Border.all(
//         color: Colors.blueAccent,
//         width: 2,
//       ),
//       borderRadius: BorderRadius.circular(12),
//     ),
//     child: Theme(
//       data: Theme.of(context).copyWith(
//         dividerColor: Colors.transparent,
//       ),
//       child: ExpansionTile(
//         title: Text(
//           item.itemName?.toString() ?? '',
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         children: List<Widget>.generate(
//           item.getAllProductionStages().length,
//               (index) {
//             final stage = item.getAllProductionStages()[index];
//             return Container(
//               decoration: const BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(
//                     color: Colors.grey,
//                     width: 1,
//                   ),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   ListTile(
//                     title: Text(stage.label.toString()),
//                   ),
//
//                   if (stage.productionChildStages != null &&
//                       stage.productionChildStages!.isNotEmpty)
//                     ExpansionTile(
//                       title: const Text('Sub-Items'),
//                       children: List<Widget>.generate(
//                         stage.productionChildStages!.length,
//                             (index) {
//                           final childStage = stage.productionChildStages![index];
//                           return ListTile(
//                             title: Text(childStage.label.toString()),
//                           );
//                         },
//                       ),
//                     ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     ),
//   );
// }