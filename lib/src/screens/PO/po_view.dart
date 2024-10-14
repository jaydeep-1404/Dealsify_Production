
import 'package:dealsify_production/src/common_functions/animations.dart';
import 'package:dealsify_production/src/screens/PO/complete_stage/stage_complete.dart';
import 'package:dealsify_production/src/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_controllers/production_order_states.dart';

// class POItemsPage extends StatefulWidget {
//   const POItemsPage({super.key});
//
//   @override
//   State<POItemsPage> createState() => _POItemsPageState();
// }
//
// class _POItemsPageState extends State<POItemsPage> {
//   final record = Get.put(PORecordCtrl());
//
//   @override
//   Widget build(BuildContext context) {
//     Map<int, String> selectedOptions = {};
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 80,
//         leadingWidth: 40,
//         leading: IconButton(
//           onPressed: () {
//             navigateToPage(context, const DashboardScreen());
//           },
//           icon: const Icon(Icons.arrow_back_ios),
//         ),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Items"),
//             Text("Customer :-  ${record.poRecord.customerId!.shortName}",style: const TextStyle(fontSize: 15),),
//             Text("PO No. :-  ${record.poRecord.productionOrderNo}",style: const TextStyle(fontSize: 15),),
//             ],
//         ),
//         centerTitle: false,
//         backgroundColor: Colors.blueGrey[300],
//       ),
//       body: ListView(
//           children: [
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: record.poRecord.items!.length,
//               itemBuilder: (context, index) {
//                 final item = record.poRecord.items![index];
//                 final stage = item.findFirstIncompleteStage();
//                 return Padding(
//                   padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
//                   child: Material(
//                     elevation: 1,
//                     borderRadius: BorderRadius.circular(8),
//                     child: CustomExpansionTile(
//                       title: item.itemName.toString(),
//                       children: [
//                         Container(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(stage!.label.toString()),
//                               buildPopupMenuButton(
//                                 boxIndex: index,
//                                 options: ['Complete stage', 'Scrap', 'Adon'],
//                                 onSelected: (value) {
//                                   setState(() {
//                                     selectedOptions[index] = value;
//                                     switch (value) {
//                                       case "Complete stage":
//                                         FocusManager.instance.primaryFocus?.unfocus();
//                                         Get.bottomSheet(
//                                           OpenBillingAddress(index: index),
//                                           isScrollControlled: true,
//                                           isDismissible: false,
//                                           backgroundColor: Colors.transparent,
//                                         );
//                                         break;
//                                       case "Scrap":
//                                         record.savePOItemIndex(index);
//                                         Get.to(const ScraptScreen());
//                                         break;
//                                       case "Adon":
//                                         record.savePOItemIndex(index);
//                                         Get.to(const AdonScreen());
//                                         break;
//                                     }
//                                   });
//                                 },
//                               ),
//                             ],),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//       ),
//     );
//   }
//
//   PopupMenuButton<String> buildPopupMenuButton({
//     required int boxIndex,
//     required List<String> options,
//     required Function(String) onSelected,
//   }) {
//     return PopupMenuButton<String>(
//       onSelected: onSelected,
//       icon: const Icon(Icons.more_vert),
//       itemBuilder: (BuildContext context) {
//         return options.map((String option) {
//           return PopupMenuItem<String>(
//             value: option,
//             child: Text(option),
//           );
//         }).toList();
//       },
//     );
//   }
// }
//
// class CustomExpansionTile extends StatelessWidget {
//   final String title;
//   final List<Widget> children;
//
//   const CustomExpansionTile({
//     Key? key,
//     required this.title,
//     required this.children,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         // border: Border.all(color: Colors.blue, width: 2),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: ExpansionTile(
//         title: Text(title),
//         tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
//         expandedAlignment: Alignment.centerLeft,
//         childrenPadding: const EdgeInsets.all(16.0),
//         children: children,
//       ),
//     );
//   }
// }



class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final record = Get.put(PORecordCtrl());
  Map<int, String> selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Order: ${record.poRecord.customerId!.customerName}', style: const TextStyle(fontSize: 16)),
            Text('Customer:  ${record.poRecord.productionOrderNo}', style: const TextStyle(fontSize: 12)),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            navigateToPage(context, const DashboardScreen());
          },
          icon: const Icon(Icons.arrow_back_ios,color: Colors.black87,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(
                   'Order Date: ${convertDateFormat(record.poRecord.orderDate.toString())}',
                   style: const TextStyle(fontSize: 13),
                 ),
                 Text(
                   'Dispatch Date: ${convertDateFormat(record.poRecord.dispatchDate.toString())}',
                   style: const TextStyle(fontSize: 13),
                 ),
               ],
            ),
            const Divider(height: 30),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Order Items',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: record.poRecord.items!.length,
                itemBuilder: (context, index) {
                  final item = record.poRecord.items![index];
                  final stage = item.findFirstIncompleteStage();
                  return ItemCard(
                    itemName: item.itemName,
                    categoryName: item.categoryName,
                    quantity: item.qty,
                    stage: stage!.label,
                    boxIndex: index,
                    options: const ['Complete stage'],
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
                            record.savePOItemIndex(index);
                            break;
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String convertDateFormat(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);
    return '${dateTime.day}-${dateTime.month}-${dateTime.year}';
  }
}

class ItemCard extends StatefulWidget {
  const ItemCard({Key? key, this.itemName, this.categoryName, this.quantity, this.stage, this.boxIndex, this.options, this.onSelected,}) : super(key: key);
  final itemName;
  final categoryName;
  final quantity;
  final stage;
  final boxIndex;
  final options;
  final onSelected;

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Item : ${widget.itemName ?? ""}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                buildPopupMenuButton(
                  boxIndex: widget.boxIndex,
                  options: widget.options,
                  onSelected: widget.onSelected,
                ),
                ],
            ),

            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category : ${widget.categoryName ?? ''}',style: const TextStyle(fontWeight: FontWeight.w500),),
                Text(
                  'Qty : ${widget.quantity ?? ''}',
                  style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.teal.shade200),
                ),
                padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Stage: ${widget.stage ?? ""}',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ]
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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