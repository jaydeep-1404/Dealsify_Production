
import 'package:dealsify_production/src/common_functions/animations.dart';
import 'package:dealsify_production/src/screens/PO/purchase_orders.dart';
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
  final dateTimeController = Get.put(StageController());
  final ScrapController formController = Get.put(ScrapController());

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
                  color: Colors.blueAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${record.activeStage.value.label}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
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
            color: Colors.black87,
          ),
        ),
      ),
      body: Obx(() {
        final stage = record.activeStage.value;
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          children: [
            Text(
              'Worker : ${stage.inspector ?? ''}',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            buildDateTimePicker(
              onSave: () {

                },
              onComplete: () {

                },
              context,
              'Start date', 'Start time',
              dateTimeController.startDate, () => dateTimeController.pickStartDate(context),
              dateTimeController.startTime, () => dateTimeController.pickStartTime(context),
            ),
            const SizedBox(height: 10),
            buildDateTimePicker(
              onSave: () {

                },
              onComplete: () {

                },
              context,
              'End date', 'End time',
              dateTimeController.endDate, () => dateTimeController.pickEndDate(context),
              dateTimeController.endTime, () => dateTimeController.pickEndTime(context),
            ),
            const SizedBox(height: 10),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dropdown
                  Obx(() => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade100,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Select Option',
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.black54),
                      ),
                      value: formController.dropdownValue.value == ''
                          ? null
                          : formController.dropdownValue.value,
                      items: const [
                        DropdownMenuItem(
                            value: 'Option 1', child: Text('Option 1')),
                        DropdownMenuItem(
                            value: 'Option 2', child: Text('Option 2')),
                        DropdownMenuItem(
                            value: 'Option 3', child: Text('Option 3')),
                      ],
                      onChanged: (value) {
                        formController.dropdownValue.value = value ?? '';
                      },
                    ),
                  )),
                  const SizedBox(height: 20),

                  // Quantity (Numeric input)
                  buildCustomTextField(
                    controller: formController.quantityController,
                    labelText: 'Quantity',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),

                  // Read-only Current Qty field
                  buildCustomTextField(
                    controller: formController.currentQtyController,
                    labelText: 'Current Qty',
                    readOnly: true,
                  ),
                  const SizedBox(height: 20),

                  // Description (Expandable)
                  buildCustomTextField(
                    controller: formController.descriptionController,
                    labelText: 'Description',
                    maxLines: null, // Makes it expandable
                  ),
                  const SizedBox(height: 20),

                  // Add Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        formController.addRecord();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Add', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ListView to show records
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: formController.records.length,
                  itemBuilder: (context, index) {
                    var record = formController.records[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text('Option: ${record.dropdownValue}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Quantity: ${record.quantity}'),
                            Text('Current Qty: ${record.currentQty}'),
                            Text('Description: ${record.description}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            formController.deleteRecord(index);
                          },
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }

  Widget buildDateTimePicker(
      BuildContext context,
      String label,
      String label2,
      Rx<DateTime> date,
      VoidCallback onDateTapped,
      Rx<TimeOfDay> time,
      VoidCallback onTimeTapped,{void Function()? onSave,void Function()? onComplete}
      ) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.only(
          top: 10, bottom: 5, left: 5, right: 5,
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
                  Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: onDateTapped,
                    child: Container(
                      height: 35,
                      width: Get.width / 2.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.teal),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Obx(() => Text(
                        "${date.value.day}-${date.value.month}-${date.value.year}",
                        style: TextStyle(color: date.value == null ? Colors.grey : Colors.black),
                      )),
                    ),
                  ),
                ],),
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.teal),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Obx(() => Text(
                          time.value.format(context),
                          style: TextStyle(color: time.value == null ? Colors.grey : Colors.black),
                        )),
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

  Widget buildSaveCompleteButton({void Function()? onSave,void Function()? onComplete}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onSave ?? () {},
          child: Container(
            height: 40,
            width: Get.width * 0.3,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey.shade400,
                width: 1,
              ),
            ),
            child: const Center(
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: onComplete ?? () {},
          child: Container(
            height: 40,
            width: Get.width * 0.3,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Complete',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCustomTextField({
    required TextEditingController controller,
    required String labelText,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
    int? maxLines = 1, // Default maxLines to 1 for normal text input
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
          labelStyle: const TextStyle(color: Colors.black54),
        ),
      ),
    );
  }

}




/*class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final PORecordCtrl record = Get.put(PORecordCtrl());
  Map<int, String> selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigateToPage(context, const DashboardScreen());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${record.poRecord.value.customerId?.shortName}', style: const TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold)),
                  Text('Order:  ${record.poRecord.value.productionOrderNo}', style: const TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                ],
              );
            }
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              navigateToPage(context, const DashboardScreen());
            },
            icon: const Icon(Icons.arrow_back_ios,color: Colors.black87,),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Order Date: ',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          TextSpan(
                            text: convertDateFormat(record.poRecord.value.orderDate.toString()),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Dispatch Date: ',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          TextSpan(
                            text: convertDateFormat(record.poRecord.value.dispatchDate.toString()),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
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
                  child: RefreshIndicator(
                    onRefresh: _refreshItems,
                    child: ListView.builder(
                      itemCount: record.poRecord.value.items!.length,
                      itemBuilder: (context, index) {
                        final item = record.poRecord.value.items![index];
                        final stage = item.findFirstIncompleteStage();
                        return ItemCard(
                          itemName: item.itemName,
                          categoryName: item.categoryName,
                          quantity: item.qty,
                          stage: stage?.label ?? '',
                          popUpEnable: stage?.label == null ? false : true,
                          stagesAvailable: item.incompleteStages().isNotEmpty ? true : false,
                          boxIndex: index,
                          options: const ['Complete stage'],
                          onSelected: (value) {
                            setState(() {
                              selectedOptions[index] = value;
                              switch (value) {
                                case "Complete stage":
                                  navigateToPage(context, const StageCompleteScreen());
                                  // FocusManager.instance.primaryFocus?.unfocus();
                                  // Get.bottomSheet(
                                  //   StageCompleteBottomSheet(index: index),
                                  //   isScrollControlled: true,
                                  //   isDismissible: false,
                                  //   backgroundColor: Colors.transparent,
                                  // );
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
                ),
              ],
            );
          },),
        ),
      ),
    );
  }

  Future<void> _refreshItems() async {
    await Future.delayed(const Duration(seconds: 2));

    final po = Get.put(PurchaseOrderController());
    po.get();
    setState(() {
      record.checkPOAndRefresh();
      setState(() {});
    });
  }

  String convertDateFormat(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);
    return '${dateTime.day}-${dateTime.month}-${dateTime.year}';
  }
}

class ItemCard extends StatefulWidget {
  const ItemCard({Key? key, this.itemName, this.categoryName, this.quantity, this.stage, this.boxIndex, this.options, this.onSelected, this.stagesAvailable, this.popUpEnable,}) : super(key: key);
  final itemName;
  final categoryName;
  final quantity;
  final stage;
  final boxIndex;
  final options;
  final onSelected;
  final stagesAvailable;
  final popUpEnable;

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
                if (widget.popUpEnable == true)
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
            if (widget.stagesAvailable == true)
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Stage: ${widget.stage ?? ""}',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ]
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text(
                    //       'Status: Not-Completed',
                    //       style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                    //     ),
                    //     const Text(
                    //       '5 More..',
                    //       style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                    //     ),
                    //   ],
                    // ),
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
      color: Colors.white,
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
}*/


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