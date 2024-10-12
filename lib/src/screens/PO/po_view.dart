
import 'package:dealsify_production/core/routs/routs.dart';
import 'package:dealsify_production/src/screens/PO/complete_stage/stage_complete.dart';
import 'package:dealsify_production/src/screens/PO/scrap/scrap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_controllers/production_order_states.dart';

class POItemsPage extends StatefulWidget {
  const POItemsPage({super.key});

  @override
  State<POItemsPage> createState() => _POItemsPageState();
}

class _POItemsPageState extends State<POItemsPage> {
  final record = Get.put(PORecordCtrl());

  @override
  Widget build(BuildContext context) {
    Map<int, String> selectedOptions = {};
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
                return CustomExpansionTile(
                  title: item.itemName.toString(),
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(stage!.label.toString()),
                          buildPopupMenuButton(
                            boxIndex: index,
                            options: ['Complete stage', 'Scrap', 'Adon'],
                            onSelected: (value) {
                              setState(() {
                                selectedOptions[index] = value;
                                switch (value) {
                                  case "Complete stage":
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    Get.bottomSheet(
                                      OpenBillingAddress(index: index),
                                      isScrollControlled: true,
                                      isDismissible: false,
                                      backgroundColor: Colors.transparent,
                                    );
                                    break;
                                  case "Scrap":
                                    Get.to(const ScraptScreen());
                                    break;
                                  case "Addon":
                                    break;
                                }
                              });
                            },
                          ),
                        ],),
                    ),
                  ],
                );
              },
            ),
          ],
      ),
    );
  }

  PopupMenuButton<String> buildPopupMenuButton({
    required int boxIndex,
    required List<String> options,
    required Function(String) onSelected,
  }) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      icon: const Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) {
        return options.map((String option) {
          return PopupMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList();
      },
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